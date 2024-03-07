import { LightningElement ,api,wire} from 'lwc';
import Id from "@salesforce/user/Id";
import { updateRecord } from 'lightning/uiRecordApi';
import getCaseById from '@salesforce/apex/WhoOpenRecordHelper.getCaseById';


export default class WhoOpenRecord extends LightningElement {
    @api field_Api_Name="";
    @api recordId
    userId = String(Id);

    connectedCallback(){
        getCaseById({recordId:this.recordId , fieldApiName:this.field_Api_Name.toString()})
        .then((data)=>{
            console.log(data[this.field_Api_Name]);
            if(data[this.field_Api_Name] == undefined){
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

        })
        .catch((error)=>{
            console.log (error)
        })
    }
}