import { LightningElement, track, wire, api } from "lwc";
import getSuggestedCases from "@salesforce/apex/CaseController.getSuggestedCases";

//define datatable columns with customized Case Number URL column
const columns = [
    {
        label: "Case Number",
        fieldName: "URLField",
        fixedWidth: 120,
        type: "url",
        typeAttributes: {
            label: {
                fieldName: "CaseNumber"
            },
            target: "_blank"
        },
        sortable: true
    },
    { label: "Subject", fieldName: "Subject" },
    { label: "Type", fieldName: "Type" }
];
export default class SuggestedCases extends LightningElement {
    @api recordId; //it will be passed from the screen
    @track records; //datatable records
    @track columns; //datatable columns

    //retrieve suggested cases based on case recordId
    @wire(getSuggestedCases, { caseId: "$recordId" })
    wiredCases({ error, data }) {
        if (data) {
            let URLField;
            //retrieve Id, create URL with Id and push it into the array
            this.records = data.map((item) => {
                URLField = "/lightning/r/Case/" + item.Id + "/view";
                return { ...item, URLField }; //use spread operator to take a deep copy
            });
            this.columns = columns;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.records = undefined;
        }
    }
}
