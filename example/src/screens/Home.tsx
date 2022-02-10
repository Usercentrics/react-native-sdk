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
    function createUsercentricsLogo(): UsercentricsLogo {
        // Logo name is used for iOS and the Image.resolveAssetSource is used for Android.
        const customLogo = new UsercentricsLogo("logo.png", Image.resolveAssetSource(require('../../assets/images/logo.png')))
        return customLogo
    }

    async function showFirstLayer() {
        const bannerSettings = new BannerSettings();

        const styleSettings: FirstLayerStyleSettings = {
            headerImage: HeaderImageSettings.logo(createUsercentricsLogo(), 30.0, SectionAlignment.center),
            buttonLayout: ButtonLayout.grid([
                [new ButtonSettings(ButtonType.acceptAll)],
                [new ButtonSettings(ButtonType.more), new ButtonSettings(ButtonType.denyAll)]]),
            cornerRadius: 30.0
        }
        
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

    async function showSecondLayer() { 
        const bannerSettings = new BannerSettings();
        const options = new SecondLayerOptions(
            bannerSettings, 
            true
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
                await Usercentrics.status();
                navigation.navigate("CustomUI")
            }} title="Custom UI" />
        </View>
    );
};