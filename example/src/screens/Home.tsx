import React from 'react';
import { Button, Image, StyleSheet, View } from 'react-native';
import {
    BannerLogo,
    BannerSettings,
    ButtonLayout,
    ButtonType,
    FirstLayerOptions,
    HeaderImageSettings, LegalLinksSettings, SecondLayerOptions,
    SectionAlignment,
    Usercentrics,
    UsercentricsLayout
} from '../../../src/index';

export const HomeScreen = ({ navigation }: { navigation: any }) => {
    async function showFirstLayer(options: FirstLayerOptions = defaultOptions) {
        const response = await Usercentrics.showFirstLayer(options);
        console.log("Consents -> ${response.consents}", response.consents);
        console.log("User Interaction -> ${response.userInteraction}", response.userInteraction);
        console.log("Controller Id -> ${response.controllerId}", response.controllerId);
    }

    async function showSecondLayer() {
        const bannerSettings: BannerSettings = {
            secondLayerStyleSettings: {
                showCloseButton: true
            }
        };
        const options = new SecondLayerOptions(bannerSettings);

        const response = await Usercentrics.showSecondLayer(options);
        console.log("Consents -> ${response.consents}", response.consents);
        console.log("User Interaction -> ${response.userInteraction}", response.userInteraction);
        console.log("Controller Id -> ${response.controllerId}", response.controllerId);
    }

    const styles = StyleSheet.create({
        container: {
            flex: 1,
            alignItems: 'center',
            justifyContent: 'space-evenly',
            height: 200,
        }
    })

    return (

        <View style={styles.container}>
            <Button onPress={async () => {
                showFirstLayer();
            }} title="Show First Layer" />

            <Button onPress={async () => {
                showSecondLayer();
            }} title="Show Second Layer" />

            <Button onPress={async () => {
                showFirstLayer(customizationExampleOne);
            }} title="Customization Example 1" />

            <Button onPress={async () => {
                showFirstLayer(customizationExampleTwo);
            }} title="Customization Example 2" />

            <Button onPress={async () => {
                await Usercentrics.status();
                navigation.navigate("CustomUI")
            }} title="Custom UI" />

            <Button onPress={async () => {
                await Usercentrics.status();
                navigation.navigate("WebviewIntegration")
            }} title="Webview Integration" />
        </View>
    );
};

const defaultOptions: FirstLayerOptions = {
    layout: UsercentricsLayout.popupCenter
}

const customizationExampleOne: FirstLayerOptions = {
    bannerSettings: {
        firstLayerStyleSettings: {
            cornerRadius: 30.0,
            title: {
                textSize: 22.0
            },
            message: {
                textSize: 14.0,
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
        generalStyleSettings: {
            font: {
                regularFont: "Lora",
                boldFont: "Lora-Regular_Bold",
                fontSize: 14.0
            },
            textColorHex: "#77ff00",
            layerBackgroundColorHex: "#fff000",
            logo: createBannerLogo(),
            links: LegalLinksSettings.secondLayerOnly,
            toggleStyleSettings: {
                activeBackgroundColorHex: "#12e09f",
                inactiveBackgroundColorHex: "#abdccd",
                disabledBackgroundColorHex: "#d47e00",
                activeThumbColorHex: "#957950",
                inactiveThumbColorHex: "#4439e9",
                disabledThumbColorHex: "c99dc1"
            }
        }
    },
    layout: UsercentricsLayout.popupBottom
}

const customizationExampleTwo: FirstLayerOptions = {
    layout: UsercentricsLayout.full,
    bannerSettings: {
        firstLayerStyleSettings: {
            cornerRadius: 20,
            backgroundColorHex: "000000",
            headerImage: HeaderImageSettings.hidden(),
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
            textColorHex: "#ffffff",
            layerBackgroundColorHex: "#000000",
            layerBackgroundSecondaryColorHex: "#6b6b6b",
            logo: createBannerLogo(),
            links: LegalLinksSettings.secondLayerOnly
        }
    }
}

function createBannerLogo(): BannerLogo {
    // Logo name is used for iOS and the Image.resolveAssetSource is used for Android.
    const customLogo = new BannerLogo("logo.png", Image.resolveAssetSource(require('../../assets/images/logo.png')))
    return customLogo
}
