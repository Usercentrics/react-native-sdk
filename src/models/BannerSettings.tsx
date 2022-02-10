import { UsercentricsLogo, UsercentricsFont } from ".";

export class BannerSettings { 
    logo?: UsercentricsLogo;
    font?: UsercentricsFont;

    constructor(logo?: UsercentricsLogo, font?: UsercentricsFont) {
        this.logo = logo;
        this.font = font;
    }
}
