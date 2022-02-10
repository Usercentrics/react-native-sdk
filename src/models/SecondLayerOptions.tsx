import { BannerSettings } from ".";

export class SecondLayerOptions {
    bannerSettings?: BannerSettings;
    showCloseButton?: Boolean;

    constructor(bannerSettings?: BannerSettings, showCloseButton: Boolean = false) {
        this.bannerSettings = bannerSettings;
        this.showCloseButton = showCloseButton;
    }
}