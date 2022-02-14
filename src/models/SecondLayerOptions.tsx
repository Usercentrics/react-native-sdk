import { BannerSettings } from ".";

export class SecondLayerOptions {
    bannerSettings?: BannerSettings;
    showCloseButton: Boolean;

    constructor(showCloseButton: Boolean, bannerSettings?: BannerSettings) {
        this.bannerSettings = bannerSettings;
        this.showCloseButton = showCloseButton;
    }
}