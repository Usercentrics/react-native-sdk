export class UsercentricsUIOptions { 
    showCloseButton: boolean;
    customLogo?: string;
    fontName?: string;
    fontSize?: number;

    constructor(showCloseButton: boolean, customLogo?: string, fontName?: string, fontSize?: number) {
        this.showCloseButton = showCloseButton;
        this.customLogo = customLogo;
        this.fontName = fontName;
        this.fontSize = fontSize;
    }
}