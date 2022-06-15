import { ImageResolvedAssetSource } from "react-native";
import { FirstLayerStyleSettings, SecondLayerStyleSettings } from ".";

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
    none = "NONE"
}

export class BannerSettings {
    logo?: BannerLogo;
    font?: BannerFont;
    links?: LegalLinksSettings;
    firstLayerSettings?: FirstLayerStyleSettings;
    secondLayerSettings?: SecondLayerStyleSettings;

    constructor(logo?: BannerLogo, font?: BannerFont, links?: LegalLinksSettings,
        firstLayerSettings?: FirstLayerStyleSettings, secondLayerSettings?: SecondLayerStyleSettings) {
        this.logo = logo;
        this.font = font;
        this.links = links;
        this.firstLayerSettings = firstLayerSettings;
        this.secondLayerSettings = secondLayerSettings;
    }
}
