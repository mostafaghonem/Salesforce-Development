import { LightningElement , track} from 'lwc';

export default class ModalParentExampleCmp extends LightningElement {
    @track showModal = false;
    @track showNegativeButton = false;
    @track showPositiveButton = true;
    @track positiveButtonLable = 'Close';


    closeModal(){
        this.showModal = false;
    }

    showModalPopup(){
        this.showModal = true;
    }

}