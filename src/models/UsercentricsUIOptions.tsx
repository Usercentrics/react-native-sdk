import { ImageResolvedAssetSource } from "react-native";

export class UsercentricsUIOptions { 
    showCloseButton: boolean;
    customLogo?: UsercentricsLogo;
    customFont?: UsercentricsFont;

    constructor(showCloseButton: boolean, customLogo?: UsercentricsLogo, customFont?: UsercentricsFont) {
        this.showCloseButton = showCloseButton;
        this.customLogo = customLogo;
        this.customFont = customFont;
    }
}

export class UsercentricsLogo {
    logoName: string;
    logoPath: string;
    logoUrl?: String;

    constructor(logoName: string, logoPath: ImageResolvedAssetSource, logoUrl?: String) {
        this.logoName = logoName;
        this.logoPath = logoPath.uri;
        this.logoUrl = logoUrl;
    }
}

export class UsercentricsFont { 
    fontName: string;
    fontSize: number;

    constructor(fontName: string, fontSize: number) {
        this.fontName = fontName;
        this.fontSize = fontSize;
    }
}