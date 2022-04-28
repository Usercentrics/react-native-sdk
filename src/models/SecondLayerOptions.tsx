import { BannerSettings, ButtonLayout } from ".";

export class SecondLayerOptions {
    bannerSettings?: BannerSettings;

    constructor(bannerSettings?: BannerSettings) {
        this.bannerSettings = bannerSettings;
    }
}

export class SecondLayerStyleSettings {
    buttonLayout?: ButtonLayout;
    showCloseButton?: Boolean;

    constructor(buttonLayout?: ButtonLayout, showCloseButton?: Boolean) {
        this.buttonLayout = buttonLayout;
        this.showCloseButton = showCloseButton;
    }
}
