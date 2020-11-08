import { LightningElement, track } from 'lwc';

export default class HeloExpression extends LightningElement {
    @track firstName = '';
    @track LastName = '';
    handleChange(event){
        const field = event.target.name;
        if(field === 'FirstName'){
            this.firstName = event.target.value;
        }
        else if(field === 'LastName'){
            this.lastName = event.target.value;
        }

    }
    get uppercasedFullName(){
        return "${this.firstName} ${this.lastName}".toUpperCase();
    }
}