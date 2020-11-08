import { LightningElement, track } from "lwc";

export default class EditContact extends LightningElement {
  @track bShowModal = false;
  @track currentRecordId;
  @track isEditForm = false;
  editCurrentRecord(currentRow) {
    // open modal box
    this.bShowModal = true;
    this.isEditForm = true;

    // assign record id to the record edit form
    this.currentRecordId = currentRow.Id;
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
        message:
          event.detail.fields.FirstName +
          " " +
          event.detail.fields.LastName +
          " Contact updated Successfully!!.",
        variant: "success"
      })
    );
  }
}
