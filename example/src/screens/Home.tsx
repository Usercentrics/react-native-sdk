import React from 'react'
import { Button, Image, StyleSheet, View } from 'react-native'
import {
    BannerSettings,
    ButtonLayout,
    ButtonSettings,
    ButtonType,
    FirstLayerOptions,
    FirstLayerStyleSettings,
    HeaderImageSettings,
    SecondLayerOptions,
    SectionAlignment,
    Usercentrics,
    UsercentricsFont,
    UsercentricsLayout,
    UsercentricsLogo
} from '../../../src/index';

export const HomeScreen = ({ navigation }: { navigation: any }) => {
    async function showFirstLayer(options: FirstLayerOptions = defaultOptions) {
        const response = await Usercentrics.showFirstLayer(options);
        console.log("Consents -> ${response.consents}", response.consents);
        console.log("User Interaction -> ${response.userInteraction}", response.userInteraction);
        console.log("Controller Id -> ${response.controllerId}", response.controllerId);
    }

    async function showSecondLayer() {
        const bannerSettings = new BannerSettings();
        const options = new SecondLayerOptions(
            true,
            bannerSettings
        );

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
        </View>
    );
};

const defaultOptions: FirstLayerOptions = {
    layout: UsercentricsLayout.popupCenter
}

const customizationExampleOne: FirstLayerOptions = {
    bannerSettings: { 
        font: { fontName: "Lora", fontSize: 16.0 },
        logo: createUsercentricsLogo()
    },
    layout: UsercentricsLayout.popupBottom,
    styleSettings: {
        cornerRadius: 30.0,
        title: {
            font: { fontName: "Lora", fontSize: 16.0 }
        },
        message: {
            font: { fontName: "Lora", fontSize: 14.0 }
        },
        buttonLayout: ButtonLayout.row([{
            buttonType: ButtonType.acceptAll,
            cornerRadius: 30.0
        }, {
            buttonType: ButtonType.more,
            backgroundColorHex: "00000000"
        }])
    }
}

const customizationExampleTwo: FirstLayerOptions = {
    layout: UsercentricsLayout.full,
    styleSettings: { 
        cornerRadius: 20,
        backgroundColorHex: "000000",
        headerImage: HeaderImageSettings.hidden(),
        title: {
            font: { fontName: "Lora", fontSize: 18.0 },
            textColorHex: "FFFFFF",
            textAlignment: SectionAlignment.center
        },
        message: {
            font: { fontName: "Lora", fontSize: 14.0 },
            textColorHex: "FFFFFF"
        },
        buttonLayout: ButtonLayout.grid([
            [
                {
                    buttonType: ButtonType.acceptAll,
                    cornerRadius: 30.0,
                    backgroundColorHex: "FFFFFF",
                    textColorHex: "000000",
                    font: { fontName: "Lora", fontSize: 18.0 }
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
    }
}

function createUsercentricsLogo(): UsercentricsLogo {
    // Logo name is used for iOS and the Image.resolveAssetSource is used for Android.
    const customLogo = new UsercentricsLogo("logo.png", Image.resolveAssetSource(require('../../assets/images/logo.png')))
    return customLogo
}