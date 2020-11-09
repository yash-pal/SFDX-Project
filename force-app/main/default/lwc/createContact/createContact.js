import { LightningElement, track, api } from "lwc";
//To show succes/error message using Lightning Toast
import { ShowToastEvent } from "lightning/platformShowToastEvent";
//Create Record using User Interface API
import { createRecord } from "lightning/uiRecordApi";
import CONTACT_OBJECT from "@salesforce/schema/Contact";
import NAME_FIELD from "@salesforce/schema/Contact.LastName";
import EMAIL_FIELD from "@salesforce/schema/Contact.Email";
import PHONE_FIELD from "@salesforce/schema/Contact.Phone";
import ACCOUNTID_FIELD from "@salesforce/schema/Contact.AccountId";

export default class CreateContact extends LightningElement {
  @track contactId;
  //Account Id passed from Parent to Child Component using API decorator.
  @api accountid;

  name = "";
  email = "";
  phone = "";

  handleNameChange(event) {
    this.contactId = undefined;
    this.name = event.target.value;
  }

  handleEmailChange(event) {
    this.email = event.target.value;
  }

  handlePhoneChange(event) {
    this.phone = event.target.value;
  }

  createContact() {
    const fields = {};
    fields[NAME_FIELD.fieldApiName] = this.name;
    fields[EMAIL_FIELD.fieldApiName] = this.email;
    fields[PHONE_FIELD.fieldApiName] = this.phone;
    fields[ACCOUNTID_FIELD.fieldApiName] = this.accountid;
    const recordInput = { apiName: CONTACT_OBJECT.objectApiName, fields };
    createRecord(recordInput)
      .then((contact) => {
        this.contactId = contact.id;
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Success",
            message: "Contact created",
            variant: "success"
          })
        );
        
      })
      .catch((error) => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error creating record",
            message: error.message,
            variant: "error"
          })
        );
      });
  }
}
