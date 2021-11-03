import React, { useCallback, useEffect } from 'react'
import { Button, Image, StyleSheet, View } from 'react-native'
import {
    Usercentrics,
    UsercentricsFont,
    UsercentricsLoggerLevel,
    UsercentricsLogo,
    UsercentricsOptions,
    UsercentricsReadyStatus,
    UsercentricsServiceConsent,
    UsercentricsUIOptions
} from '../../../src/index';

export const HomeScreen = ({ navigation }: { navigation: any }) => {
    const [cmpStatus, setStatus] = React.useState<UsercentricsReadyStatus>()

    const getIsReadyStatus = useCallback(async () => {
        let data = await Usercentrics.status();
        setStatus(data);
    }, [])

    useEffect(() => {
        // let options = new UsercentricsOptions("Yi9N3aXia");
        // let options = new UsercentricsOptions("eQ6JwYNPb");
        let options = new UsercentricsOptions("EA4jnNPb9");

        options.loggerLevel = UsercentricsLoggerLevel.debug;
        Usercentrics.configure(options);

        getIsReadyStatus();
    }, [getIsReadyStatus]);

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

    const styles = StyleSheet.create({
        container: {
            flex: 1,
            alignItems: 'center',
            justifyContent: 'space-evenly',
            height: 200,
        }
    })

    function applyConsents(consents: [UsercentricsServiceConsent]) {
        // https://docs.usercentrics.com/cmp_in_app_sdk/latest/apply_consent/apply-consent/#apply-consent-to-each-service
    }


    return (
        <View style={styles.container}>
            <Button onPress={() => {
                showCMP(true);
            }} title="Show PredefinedUI"
                disabled={cmpStatus == undefined}
            />

            <Button onPress={() => {
                navigation.navigate("CustomUI")
            }} title="Custom UI"
                disabled={cmpStatus == undefined}
            />
        </View>
    );
};