import { LightningElement ,api} from 'lwc';
import Id from "@salesforce/user/Id";
import { updateRecord } from 'lightning/uiRecordApi';

export default class WhoOpenRecord extends LightningElement {
    @api field_Api_Name;
    @api recordId
    userId = String(Id);


    connectedCallback(){
        const fields ={};
        fields['Id'] = this.recordId;
        fields[this.field_Api_Name] = this.userId;
        const recordInput = { 
            fields 
        };

        updateRecord(recordInput)
        .then(()=>{
            console.log('Record Updated Successfully')
        })
        .catch((err)=>{
            console.log(`Error: ${JSON.stringify(err.body.message)}`)
        })
    }
}