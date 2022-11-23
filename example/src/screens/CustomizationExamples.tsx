import { Image } from 'react-native';
import {
    BannerLogo, BannerSettings, ButtonLayout,
    ButtonType,
    HeaderImageSettings,
    LegalLinksSettings,
    SectionAlignment,
    UsercentricsLayout
} from '../../../src/index';

export const customizationExampleOne: BannerSettings = {
    firstLayerStyleSettings: {
        layout: UsercentricsLayout.popupCenter,
        cornerRadius: 30.0,
        title: {
            textSize: 20.0,
            textAlignment: SectionAlignment.center,
            textColorHex: "000000",
        },
        message: {
            textSize: 16.0,
            textAlignment: SectionAlignment.left,
            textColorHex: "181818",
            linkTextColorHex: "000000",
            linkTextUnderline: true,
        },
        buttonLayout: ButtonLayout.row(
            [
                {
                    buttonType: ButtonType.acceptAll,
                    cornerRadius: 30.0
                }, {
                    buttonType: ButtonType.more,
                    backgroundColorHex: "00000000"
                }
            ]
        )
    },
    secondLayerStyleSettings: {
        showCloseButton: true,
    },
    generalStyleSettings: {
        font: {
            regularFont: "Lora",
            boldFont: "Lora-Regular_Bold",
            fontSize: 14.0
        },
        logo: createBannerLogo(),
        links: LegalLinksSettings.both,
    }
}

export const customizationExampleTwo: BannerSettings = {
    firstLayerStyleSettings: {
        layout: UsercentricsLayout.full,
        cornerRadius: 20,
        backgroundColorHex: "181818",
        headerImage: HeaderImageSettings.logo(createBannerLogo()),
        title: {
            textSize: 22.0,
            textColorHex: "FFFFFF",
            textAlignment: SectionAlignment.center
        },
        message: {
            textSize: 18.0,
            textColorHex: "FFFFFF"
        },
        buttonLayout: ButtonLayout.grid([
            [
                {
                    buttonType: ButtonType.acceptAll,
                    cornerRadius: 30.0,
                    backgroundColorHex: "FFFFFF",
                    textColorHex: "000000",
                }, {
                    buttonType: ButtonType.denyAll,
                    backgroundColorHex: "00000000",
                    textColorHex: "FFFFFF"
                }
            ], [
                {
                    buttonType: ButtonType.more,
                    cornerRadius: 30.0,
                    textColorHex: "000000"
                }
            ]
        ])
    },
    generalStyleSettings: {
        font: {
            regularFont: "Lora",
            boldFont: "Lora-Regular_Bold",
            fontSize: 14.0
        },
        linkColorHex: "FFFFFF",
        tabColorHex: "FFFFFF",
        textColorHex: "#e1e1e1",
        layerBackgroundColorHex: "#181818",
        layerBackgroundSecondaryColorHex: "#2a2a2a",
        bordersColorHex: "2a2a2a",
        logo: createBannerLogo(),
        links: LegalLinksSettings.secondLayerOnly
    }
}


function createBannerLogo(): BannerLogo {
    // Logo name is used for iOS and the Image.resolveAssetSource is used for Android.
    const customLogo = new BannerLogo("logo.png", Image.resolveAssetSource(require('../../assets/images/logo.png')))
    return customLogo
}
