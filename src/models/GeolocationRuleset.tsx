export class GeolocationRuleset {

    activeSettingsId: string;
    bannerRequiredAtLocation: boolean;

    constructor(activeSettingsId: string, bannerRequiredAtLocation: boolean) {
        this.activeSettingsId = activeSettingsId
        this.bannerRequiredAtLocation = bannerRequiredAtLocation
    }
}
