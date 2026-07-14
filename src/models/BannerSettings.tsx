import {ImageResolvedAssetSource} from "react-native";
import {BannerInitCustomization, FirstLayerStyleSettings, SecondLayerStyleSettings} from ".";

export class BannerLogo {

    logoName: string;
    logoPath: string;
    logoUrl?: String;

    constructor(logoName: string, logoPath: ImageResolvedAssetSource, logoUrl?: String) {
        this.logoName = logoName;
        this.logoPath = logoPath.uri;
        this.logoUrl = logoUrl;
    }
}

export class BannerFont {

    regularFont: string;
    boldFont: string;
    fontSize: number;

    constructor(regularFont: string, boldFont: string, fontSize: number) {
        this.regularFont = regularFont;
        this.boldFont = boldFont;
        this.fontSize = fontSize;
    }
}

export enum LegalLinksSettings {

    firstLayerOnly = "FIRST_LAYER_ONLY",
    secondLayerOnly = "SECOND_LAYER_ONLY",
    both = "BOTH",
    hidden = "HIDDEN"
}

export class ToggleStyleSettings {

    activeBackgroundColorHex?: String;
    inactiveBackgroundColorHex?: String;
    disabledBackgroundColorHex?: String;
    activeThumbColorHex?: String;
    inactiveThumbColorHex?: String;
    disabledThumbColorHex?: String;

    constructor(
        activeBackgroundColorHex?: String,
        inactiveBackgroundColorHex?: String,
        disabledBackgroundColorHex?: String,
        activeThumbColorHex?: String,
        inactiveThumbColorHex?: String,
        disabledThumbColorHex?: String
    ) {
        this.activeBackgroundColorHex = activeBackgroundColorHex;
        this.inactiveBackgroundColorHex = inactiveBackgroundColorHex;
        this.disabledBackgroundColorHex = disabledBackgroundColorHex;
        this.activeThumbColorHex = activeThumbColorHex;
        this.inactiveThumbColorHex = inactiveThumbColorHex;
        this.disabledThumbColorHex = disabledThumbColorHex;
    }
}

export class GeneralStyleSettings {

    font?: BannerFont;
    logo?: BannerLogo;
    links?: LegalLinksSettings;
    textColorHex?: String;
    layerBackgroundColorHex?: String;
    layerBackgroundSecondaryColorHex?: String;
    linkColorHex?: String;
    tabColorHex?: String;
    bordersColorHex?: String;
    toggleStyleSettings?: ToggleStyleSettings;
    disableSystemBackButton?: Boolean;

    constructor(font?: BannerFont,
                logo?: BannerLogo,
                links?: LegalLinksSettings,
                textColorHex?: String,
                layerBackgroundColorHex?: String,
                layerBackgroundSecondaryColorHex?: String,
                linkColorHex?: String,
                tabColorHex?: String,
                bordersColorHex?: String,
                toggleStyleSettings?: ToggleStyleSettings,
                disableSystemBackButton?: Boolean
    ) {
        this.font = font;
        this.logo = logo;
        this.links = links;
        this.textColorHex = textColorHex;
        this.layerBackgroundColorHex = layerBackgroundColorHex;
        this.layerBackgroundSecondaryColorHex = layerBackgroundSecondaryColorHex;
        this.linkColorHex = linkColorHex;
        this.tabColorHex = tabColorHex;
        this.bordersColorHex = bordersColorHex;
        this.toggleStyleSettings = toggleStyleSettings;
        this.disableSystemBackButton = disableSystemBackButton;
    }
}

export class BannerSettings {

    firstLayerStyleSettings?: FirstLayerStyleSettings;
    secondLayerStyleSettings?: SecondLayerStyleSettings;
    generalStyleSettings?: GeneralStyleSettings;
    variantName?: String
    /**
     * @deprecated initCustomization is deprecated and will be removed in a future release.
     * Configure banner appearance via the Usercentrics dashboard instead.
     */
    initCustomization?: BannerInitCustomization;

    constructor(firstLayerStyleSettings?: FirstLayerStyleSettings, secondLayerStyleSettings?: SecondLayerStyleSettings, generalStyleSettings?: GeneralStyleSettings, variantName?: String, initCustomization?: BannerInitCustomization) {
        this.firstLayerStyleSettings = firstLayerStyleSettings;
        this.secondLayerStyleSettings = secondLayerStyleSettings;
        this.generalStyleSettings = generalStyleSettings;
        this.variantName = variantName;
        this.initCustomization = initCustomization;
    }
}
