import React from 'react';
import { Alert, Button, StyleSheet, View } from 'react-native';
import {
    BannerSettings,
    Usercentrics,
    UsercentricsConsentUserResponse,
    UsercentricsServiceConsent,
} from '@usercentrics/react-native-sdk';
import { customizationExampleOne, customizationExampleTwo, windowFullscreenExample } from './CustomizationExamples';

export const HomeScreen = ({ navigation }: { navigation: any }) => {
    function applyConsent(_consents?: UsercentricsServiceConsent[] | null) {
        // https://docs.usercentrics.com/cmp_in_app_sdk/latest/apply_consent/apply-consent/#apply-consent-to-each-service
    }

    const handleUserResponse = React.useCallback((response: UsercentricsConsentUserResponse | null) => {
        console.log('Consents ->', response?.consents);
        console.log('User Interaction ->', response?.userInteraction);
        console.log('Controller Id ->', response?.controllerId);
        applyConsent(response?.consents);
    }, []);

    const showFirstLayer = React.useCallback(async (bannerSettings: BannerSettings = new BannerSettings()) => {
        try {
            const response = await Usercentrics.showFirstLayer(bannerSettings);
            handleUserResponse(response);
        } catch (e) {
            console.error('[Usercentrics] showFirstLayer failed:', e);
        }
    }, [handleUserResponse]);

    React.useEffect(() => {
        Usercentrics.status()
            .then(status => {
                console.log('[Usercentrics] status:', JSON.stringify(status));
                if (status.shouldCollectConsent) {
                    showFirstLayer();
                } else {
                    applyConsent(status.consents);
                }
            })
            .catch(e => console.error('[Usercentrics] status failed:', e));
    }, [showFirstLayer]);

    React.useEffect(() => {
        const loginSubscription = Usercentrics.onLoginClicked(async (url) => {
            console.log('[Usercentrics] onLoginClicked:', url);
            Alert.alert('onLoginClicked', `url: ${url}`);
            try {
                await Usercentrics.notifyLoginSuccess();
                console.log('[Usercentrics] notifyLoginSuccess done');
                Alert.alert('notifyLoginSuccess', 'TCF storage cleared');
            } catch (e) {
                console.error('[Usercentrics] notifyLoginSuccess failed:', e);
                Alert.alert('notifyLoginSuccess failed', String(e));
            }
        });
        const subscribeSubscription = Usercentrics.onSubscribeClicked(async (url) => {
            console.log('[Usercentrics] onSubscribeClicked:', url);
            Alert.alert('onSubscribeClicked', `url: ${url}`);
            try {
                await Usercentrics.notifySubscribeSuccess();
                console.log('[Usercentrics] notifySubscribeSuccess done');
                Alert.alert('notifySubscribeSuccess', 'TCF storage cleared');
            } catch (e) {
                console.error('[Usercentrics] notifySubscribeSuccess failed:', e);
                Alert.alert('notifySubscribeSuccess failed', String(e));
            }
        });
        return () => {
            loginSubscription.remove();
            subscribeSubscription.remove();
        };
    }, []);

    async function notifySubscriptionLapsed() {
        try {
            await Usercentrics.notifySubscriptionLapsed();
            console.log('[Usercentrics] notifySubscriptionLapsed done');
            Alert.alert('notifySubscriptionLapsed', 'Subscription reset');
        } catch (e) {
            console.error('[Usercentrics] notifySubscriptionLapsed failed:', e);
            Alert.alert('notifySubscriptionLapsed failed', String(e));
        }
    }

    async function showSecondLayer() {
        try {
            const response = await Usercentrics.showSecondLayer({
                secondLayerStyleSettings: { showCloseButton: true },
            });
            handleUserResponse(response);
        } catch (e) {
            console.error('[Usercentrics] showSecondLayer failed:', e);
        }
    }

    // A/B testing example — use Usercentrics native variant
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
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
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
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
            <Button onPress={() => showFirstLayer(windowFullscreenExample)} title="Window Fullscreen (Android)" />
            <Button onPress={async () => { await Usercentrics.status(); navigation.navigate('CustomUI'); }} title="Custom UI" />
            <Button onPress={async () => { await Usercentrics.status(); navigation.navigate('WebviewIntegration'); }} title="Webview Integration" />
            <Button onPress={() => navigation.navigate('GPPTesting')} title="GPP Testing" />
            <Button onPress={notifySubscriptionLapsed} title="Notify Subscription Lapsed" />
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
