import { ButtonLayout } from ".";

export class SecondLayerStyleSettings {
    buttonLayout?: ButtonLayout;
    showCloseButton?: Boolean;

    constructor(buttonLayout?: ButtonLayout, showCloseButton?: Boolean) {
        this.buttonLayout = buttonLayout;
        this.showCloseButton = showCloseButton;
    }
}
