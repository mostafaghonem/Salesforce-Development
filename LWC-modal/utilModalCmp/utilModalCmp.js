import { LightningElement, api } from "lwc";

export default class UtilModalCmp extends LightningElement {
	@api showPositive;
	@api showNegative;
	@api positiveButtonLabel = "Save";
	@api negativeButtonLable = "Cancel";
	@api showModal;

	handlePositive() {
		this.dispatchEvent(new CustomEvent("positive"));
	}

	handleNegative() {
		this.dispatchEvent(new CustomEvent("negative"));
	}

	handleClose() {
		this.dispatchEvent(new CustomEvent("close"));
	}
}
