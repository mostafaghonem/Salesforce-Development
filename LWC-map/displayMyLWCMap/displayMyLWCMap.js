import { LightningElement, wire, track, api } from "lwc";
import getOfficeLocations from "@salesforce/apex/DisplayMyMapController.getOfficeLocations";

export default class DisplayMyLWCMap extends LightningElement {
    // @api accountNameParam;
    // accountNameParam = "University of Arizona";
    @api recordId;
    @track error; //this holds errors
    @track mapMarkers = [];
    @track markersTitle = "";
    @track zoomLevel = 4;

    @wire(getOfficeLocations, { accountId: "$recordId" })
    wiredOfficeLocations({ error, data }) {
        if (data) {
            data.forEach((dataItem) => {
                this.mapMarkers = [
                    ...this.mapMarkers,
                    {
                        location: {
                            City: dataItem.BillingCity,
                            Country: dataItem.BillingCountry
                        }
                    },
                    {
                        location: {
                            City: dataItem.ShippingCity,
                            PostalCode: dataItem.ShippingPostalCode,
                            State: dataItem.ShippingState,
                            Street: dataItem.ShippingStreet
                        },
                        icon: "custom:custom26",
                        title: dataItem.Name
                    }
                ];
            });
            this.error = undefined;
        } else if (error) {
            this.error = error;
        }
    }
}
