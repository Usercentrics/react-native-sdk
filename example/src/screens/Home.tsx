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
    SectionAlignment,
    Usercentrics,
    UsercentricsFont,
    UsercentricsLayout,
    UsercentricsLogo,
    UsercentricsUIOptions
} from '../../../src/index';

export const HomeScreen = ({ navigation }: { navigation: any }) => {
    async function showCMP(showCloseButton: boolean) {
        const options = new UsercentricsUIOptions(showCloseButton)
        options.customLogo = createUsercentricsLogo();

        const font = new UsercentricsFont("Lora", 14)
        options.customFont = font

        const response = await Usercentrics.showCMP(options)
        console.log("Consents -> ${response.consents}", response.consents);
        console.log("User Interaction -> ${response.userInteraction}", response.userInteraction);
        console.log("Controller Id -> ${response.controllerId}", response.controllerId);
    }

    function createUsercentricsLogo(): UsercentricsLogo {
        // Logo name is used for iOS and the Image.resolveAssetSource is used for Android.
        const customLogo = new UsercentricsLogo("logo.png", Image.resolveAssetSource(require('../../assets/images/logo.png')))
        return customLogo
    }

    async function showFirstLayer() {
        const bannerSettings = new BannerSettings();

        const styleSettings = new FirstLayerStyleSettings(
            HeaderImageSettings.logo(createUsercentricsLogo(), 30.0, SectionAlignment.right),
            {
                font: new UsercentricsFont("Lora", 16),
                textColorHex: "0045FF",
                textAlignment: SectionAlignment.center
            },
            {
                font: new UsercentricsFont("Lora", 14),
                textColorHex: "00F0FF",
                textAlignment: SectionAlignment.center,
                linkTextColorHex: "000000",
                linkTextUnderline: true,
            },

            ButtonLayout.grid([
                [new ButtonSettings(ButtonType.acceptAll, new UsercentricsFont("Lora", 16), "00ff00")],
                [new ButtonSettings(ButtonType.more), new ButtonSettings(ButtonType.denyAll)]])
        );

        const options = new FirstLayerOptions(
            UsercentricsLayout.popupCenter,
            bannerSettings,
            styleSettings
        );

        const response = await Usercentrics.showFirstLayer(options);
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
                showCMP(true);
            }} title="Show PredefinedUI" />

            <Button onPress={async () => {
                showFirstLayer();
            }} title="Show First Layer" />

            <Button onPress={async () => {
                await Usercentrics.status();
                navigation.navigate("CustomUI")
            }} title="Custom UI" />
        </View>
    );
};