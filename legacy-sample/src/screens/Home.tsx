
import React from 'react';
import { Button, StyleSheet, View } from 'react-native';
import {
    BannerSettings, Usercentrics
} from '../../../src/index';
import {
    customizationExampleOne,
    customizationExampleTwo
} from './CustomizationExamples';

export const HomeScreen = ({ navigation }: { navigation: any }) => {
    async function showFirstLayer(bannerSettings: BannerSettings = new BannerSettings()) {
        const response = await Usercentrics.showFirstLayer(bannerSettings);
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

        const response = await Usercentrics.showSecondLayer(bannerSettings);
        console.log("Consents -> ${response.consents}", response.consents);
        console.log("User Interaction -> ${response.userInteraction}", response.userInteraction);
        console.log("Controller Id -> ${response.controllerId}", response.controllerId);
    }

    async function getBannerSettings() {
        const variant = await Usercentrics.getABTestingVariant()
        let bannerSettings: BannerSettings;

        switch (variant) {
            case "variantA":
                return bannerSettings = {/* settings for the banner with variantA */ };
            case "variantB":
                return bannerSettings = {/* settings for the banner with variantB */ };
            default:
                return bannerSettings = {/* default banner settings*/ };
        }
    }

    //'Activate with third-party tool' option
    async function getBannerSettingsThirdPartyTool() {
        const variant = ThirdPartyTool.getABTestingVariant()
        let bannerSettings: BannerSettings;

        switch (variant) {
            case "variantA":
                return bannerSettings = {/* settings for the banner with variantA */ variantName: "variantA" };
            case "variantB":
                return bannerSettings = {/* settings for the banner with variantB */ variantName: "variantB" };
            default:
                return bannerSettings = {/* default banner settings*/variantName: "variantC" };
        }
    }

    const ThirdPartyTool = {
        getABTestingVariant: (): String | null => {
            const variants = ["variantA", "variantB"]
            const random = Math.floor(Math.random() * variants.length);
            return variants[random];
        }
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
