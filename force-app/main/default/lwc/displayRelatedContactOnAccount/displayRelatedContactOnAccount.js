/*eslint no-console: ["error", { allow: ["warn", "error"] }] */
import { LightningElement, track, wire, api } from "lwc";
import findContacts from "@salesforce/apex/AccountContactController.getContacts";
import deleteRecords from "@salesforce/apex/AccountContactController.deleteContacts";
import updateCheckbox from "@salesforce/apex/AccountContactController.updateContacts";
import { NavigationMixin } from "lightning/navigation";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { refreshApex } from "@salesforce/apex";
import { updateRecord, getRecordNotifyChange } from "lightning/uiRecordApi";
//import { registerListener, fireEvent } from "c/pubsub";
import { encodeDefaultFieldValues } from "lightning/pageReferenceUtils";

export default class displayRelatedContactOnAccount extends NavigationMixin(
  LightningElement
) {
  @track searchKey = "";
  @api recordId;
  @api objectApiName;
  @track conId;
  @track checkBoxField;
  @track error;
  @track contactss;
  @track bShowModal = false;
  @track currentRecordId;
  @track isEditForm = false;
  @track isCreateCon = false;

  @wire(findContacts, { searchKey: "$searchKey" })
  contacts;

  connectedCallback() {
    this.searchKey = this.recordId;
    /*findContacts({ searchKey: this.searchKey }).then((data) => {
      this.contactss = data;
      alert("aasd" + JSON.stringify(this.contactss[0]));
    });*/
  }

  handleContactView(event) {
    // Navigate to contact record page
    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: event.target.value,
        url:
          "https://niet-org-dev-ed.lightning.force.com/lightning/o/Contact/ " +
          this.recordId,
        objectApiName: "Contact",
        actionName: "view"
      }
    });
  }

  handleDelete(event) {
    this.recordId = event.target.value;
    deleteRecords({ lstConIds: this.recordId })
      .then(() => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Success",
            message: "Record deleted",
            variant: "success"
          })
        );
        return refreshApex(this.contacts);
      })
      .catch((error) => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error deleting record",
            message: error.body.message,
            variant: "error"
          })
        );
      });
  }

  handleEdit(event) {
    this.conId = event.target.value;
    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: this.conId,
        objectApiName: "Contact",
        actionName: "edit"
      }
    });
    debugger;

    eval("$A.get('e.force:refreshView').fire();");
    //window.reload();
    //this.forceRefreshView();
    //eval("$A.get('e.force:refreshView').fire();");

    /*alert(this.contacts);
      return refreshApex(this.contacts);*/

    /*updateRecord(this.contacts).then(() => {

      .then(
      alert("sanjdna" + this.contact);
      // Display fresh data in the form
      return refreshApex(this.contact);
    });
    /* const promises = updateRecord(this.contacts);
    Promise.all(promises).then((result) => {});*/
  }

  createContact() {
    this.bShowModal = true;
    this.isCreateCon = true;
    /*const defaultValues = encodeDefaultFieldValues({
      AccountId: this.searchKey
    });

    this[NavigationMixin.Navigate]({
      type: "standard__objectPage",
      attributes: {
        objectApiName: "Contact",
        actionName: "new"
      },
      state: {
        defaultFieldValues: defaultValues
      }
    });*/
  }

  handleCheckBoxChange(event) {
    this.recordId = event.target.value;
    alert("record" + this.recordId);
    updateCheckbox({ lstRecordId: this.recordId }).then(() => {
      this.template
        .querySelectorAll('[data-element="checkbox"]')
        .forEach((element) => {
          element.checked = true;
        });
      this.checked = false;

      alert("Record Value" + lstRecordId);
      //this.checkBoxField = event.target.checked;
      alert("checkbox" + this.checkBoxField);
      /*const boxes = this.template.querySelectorAll("lightning-input");
      boxes.forEach((box) => (box.checked = event.target.name === box.name));*/
      alert("this " + this.contacts);
      return refreshApex(this.contacts);
    });
  }

  editCurrentRecord(event) {
    // open modal box
    this.bShowModal = true;
    this.isEditForm = true;

    // assign record id to the record edit form
    this.currentRecordId = event.target.value; //currentRow.Id;
  }

  handleSubmit(event) {
    // prevending default type sumbit of record edit form
    event.preventDefault();

    // querying the record edit form and submiting fields to form
    this.template
      .querySelector("lightning-record-edit-form")
      .submit(event.detail.fields);

    // closing modal
    this.bShowModal = false;

    // showing success message
    this.dispatchEvent(
      new ShowToastEvent({
        title: "Success!!",
        message: " Contact updated Successfully!!.",
        variant: "success"
      })
    );
  }

  closeModal() {
    this.bShowModal = false;
  }

  handleSuccess() {
    return refreshApex(this.contacts);
  }

  handleCreate(event) {
    this.recordId = this.searchKey;
    event.preventDefault();

    // querying the record edit form and submiting fields to form
    this.template
      .querySelector("slds-modal__content")
      .submit(event.detail.fields);

    // closing modal
    this.bShowModal = false;

    // showing success message
    this.dispatchEvent(
      new ShowToastEvent({
        title: "Success!!",
        message: " Contact updated Successfully!!.",
        variant: "success"
      })
    );
    this.dispatchEvent(event);
  }

  /*forceRefreshView() {
     let i;
    let checkboxes = this.template.querySelectorAll('[data-id="checkbox"]');
    for (i = 0; i < checkboxes.length; i++) {
      checkboxes[i].checked = event.target.checked;
    }
    // eslint-disable-next-line no-console
    console.log("Calling Refresh from LWC");
    fireEvent(this.pageRef, "refreshfromlwc", this.contacts);
  }*/
}
