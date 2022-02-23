import { ImageResolvedAssetSource } from "react-native";

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

export class BannerSettings { 
    logo?: BannerLogo;
    font?: BannerFont;

    constructor(logo?: BannerLogo, font?: BannerFont) {
        this.logo = logo;
        this.font = font;
    }
}
