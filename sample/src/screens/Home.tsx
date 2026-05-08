import React from 'react';
import { Button, StyleSheet, View } from 'react-native';
import {
    BannerSettings,
    Usercentrics,
    UsercentricsConsentUserResponse,
    UsercentricsServiceConsent,
} from '@usercentrics/react-native-sdk';
import { customizationExampleOne, customizationExampleTwo } from './CustomizationExamples';

export const HomeScreen = ({ navigation }: { navigation: any }) => {
    React.useEffect(() => {
        Usercentrics.status().then(status => {
            if (status.shouldCollectConsent) {
                showFirstLayer();
            } else {
                applyConsent(status.consents);
            }
        });
    }, []);

    async function showFirstLayer(bannerSettings: BannerSettings = new BannerSettings()) {
        const response = await Usercentrics.showFirstLayer(bannerSettings);
        handleUserResponse(response);
    }

    async function showSecondLayer() {
        const response = await Usercentrics.showSecondLayer({
            secondLayerStyleSettings: { showCloseButton: true },
        });
        handleUserResponse(response);
    }

    function handleUserResponse(response: UsercentricsConsentUserResponse | null) {
        console.log('Consents ->', response?.consents);
        console.log('User Interaction ->', response?.userInteraction);
        console.log('Controller Id ->', response?.controllerId);
        applyConsent(response?.consents);
    }

    function applyConsent(_consents?: UsercentricsServiceConsent[] | null) {
        // https://docs.usercentrics.com/cmp_in_app_sdk/latest/apply_consent/apply-consent/#apply-consent-to-each-service
    }

    // A/B testing example — use Usercentrics native variant
    async function getBannerSettings() {
        const variant = await Usercentrics.getABTestingVariant();
        switch (variant) {
            case 'variantA':
                return {/* BannerSettings for variantA */} as BannerSettings;
            case 'variantB':
                return {/* BannerSettings for variantB */} as BannerSettings;
            default:
                return {/* default BannerSettings */} as BannerSettings;
        }
    }

    // A/B testing example — use a third-party tool for variant resolution
    async function getBannerSettingsThirdPartyTool() {
        const variant = ThirdPartyTool.getABTestingVariant();
        switch (variant) {
            case 'variantA':
                return {/* BannerSettings for variantA */ variantName: 'variantA'} as BannerSettings;
            case 'variantB':
                return {/* BannerSettings for variantB */ variantName: 'variantB'} as BannerSettings;
            default:
                return {/* default BannerSettings */ variantName: 'variantC'} as BannerSettings;
        }
    }

    const ThirdPartyTool = {
        getABTestingVariant: (): string | null => {
            const variants = ['variantA', 'variantB'];
            return variants[Math.floor(Math.random() * variants.length)];
        },
    };

    return (
        <View style={styles.container}>
            <Button onPress={() => showFirstLayer()} title="Show First Layer" />
            <Button onPress={showSecondLayer} title="Show Second Layer" />
            <Button onPress={() => showFirstLayer(customizationExampleOne)} title="Customization Example 1" />
            <Button onPress={() => showFirstLayer(customizationExampleTwo)} title="Customization Example 2" />
            <Button onPress={async () => { await Usercentrics.status(); navigation.navigate('CustomUI'); }} title="Custom UI" />
            <Button onPress={async () => { await Usercentrics.status(); navigation.navigate('WebviewIntegration'); }} title="Webview Integration" />
            <Button onPress={() => navigation.navigate('GPPTesting')} title="GPP Testing" />
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'space-evenly',
        height: 200,
    },
});
