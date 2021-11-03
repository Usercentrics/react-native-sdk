import * as React from 'react';
import { Button, StyleSheet, View, Text } from 'react-native'
import {
    TCFDecisionUILayer,
    TCFUserDecisionOnPurpose,
    TCFUserDecisionOnSpecialFeature,
    TCFUserDecisionOnVendor,
    TCFUserDecisions,
    Usercentrics,
    UsercentricsCMPData,
    UsercentricsConsentType,
    UsercentricsServiceConsent,
    UsercentricsVariant,
    UserDecision
} from '../../../src/index';

export const CustomScreen = () => {
    const [data, setData] = React.useState<UsercentricsCMPData>()

    const getActiveVariant = React.useCallback(async () => {
        let data = await Usercentrics.getCMPData();
        setData(data);
    }, [])

    React.useEffect(() => {
        getActiveVariant();
    }, [getActiveVariant]);


    const styles = StyleSheet.create({
        container: {
            flex: 1,
            alignItems: 'center',
            justifyContent: 'space-between',
            margin: 32,
            padding: 8,
            height: 200,
        }
    })

    const activeVariantTitle = () => {
        if (data != undefined) {
            switch (data.activeVariant) {
                case UsercentricsVariant.default:
                    return "GDPR";

                case UsercentricsVariant.tcf:
                    return "TCF";

                case UsercentricsVariant.ccpa:
                    return "CCPA";
            }
        } else {
            return ""
        }
    }

    function printUIElements() {
        if (data == undefined) return;
        switch (data.activeVariant) {
            case UsercentricsVariant.default:
                return printGDPR();

            case UsercentricsVariant.tcf:
                return printTCF();

            case UsercentricsVariant.ccpa:
                return printCCPA();
        }
    }

    function printGDPR() {
        if (data == undefined) return;
        const settings = data.settings;

        console.log(`Title: ${settings.labels.firstLayerTitle}`);
        console.log(`Description: ${settings.bannerMessage}`);

        console.log(`data.settings: $settings`);
        console.log(`data.services: ${data.services}`);
        console.log(`data.categories: ${data.categories}`);

        console.log(`Accept All button: ${settings.labels.btnAcceptAll}`);
        console.log(`Deny button: ${settings.labels.btnDeny}`);
        console.log(`Save button: ${settings.labels.btnSave}`);
    }

    function printTCF() {
        if (data == undefined) return;
        const ccpa = data.settings.ccpa;

        Usercentrics.setCMPId(123);

        console.log(`Title: ${ccpa?.firstLayerTitle}`);
        console.log(`Description: ${ccpa?.appFirstLayerDescription}`);

        data.categories.forEach(category => {
            console.log(`Category name: ${category.label}`);
        })

        data.services.forEach(service => {
            console.log(`Data processor: ${service.dataProcessor} with Template Id: ${service.templateId}`);
        })

        console.log(`Do not sell my info: ${ccpa?.optOutNoticeLabel}`);
        console.log(`Save: ${ccpa?.btnSave}`);
    }

    async function printCCPA() {
        if (data == undefined) return;

        console.log("Set your CMP ID");
        // Usercentrics.cmpId = 0; TODO

        const tcf2 = data.settings.tcf2;

        console.log(`First layer title: ${tcf2?.firstLayerTitle}`);
        console.log(`First layer description: ${tcf2?.firstLayerDescription}`);

        console.log(`Second layer title: ${tcf2?.secondLayerTitle}`);
        console.log(`Second layer description: ${tcf2?.secondLayerDescription}`);

        const tcfData = await Usercentrics.getTCFData();
        tcfData.purposes.forEach(purpose => {
            console.log(`Purpose: ${purpose.name}`);
        })

        tcfData.specialPurposes.forEach(specialPurpose => {
            console.log(`Special Purpose: ${specialPurpose.name}`);
        })


        tcfData.features.forEach(feature => {
            console.log(`Feature: ${feature.name}`);
        })

        tcfData.specialFeatures.forEach(specialFeature => {
            console.log(`Special Feature: ${specialFeature.name}`);
        })

        tcfData.stacks.forEach(stack => {
            console.log(`Stack: ${stack.name}`);
        })

        tcfData.vendors.forEach(vendor => {
            console.log(`Vendor: ${vendor.name}`);
        })

        // Non-IAB data
        data.categories.forEach(category => {
            console.log(`Category name: ${category.label}`);
        })

        data.services.forEach(service => {
            console.log(`Data processor: ${service.dataProcessor} with Template Id: ${service.templateId}`);
        })

        console.log(`Accept All button: ${tcf2?.buttonsAcceptAllLabel}`);
        console.log(`Deny button: ${tcf2?.buttonsDenyAllLabel}`);
        console.log(`Save button: ${tcf2?.buttonsSaveLabel}`);

        console.log(`TCString ${await Usercentrics.getTCFString()}`);
    }

    async function changeLanguage() {
        let newLanguage = "de";
        await Usercentrics.changeLanguage(newLanguage);

        let data = await Usercentrics.getCMPData();
        console.log(data);
    }

    async function acceptAll() {
        if (data == undefined) return;

        let consents: [UsercentricsServiceConsent]
        switch (data.activeVariant) {
            case UsercentricsVariant.default:
                consents = await Usercentrics.acceptAll(UsercentricsConsentType.explicit);
                break;
            case UsercentricsVariant.tcf:
                consents = await Usercentrics.acceptAllForTCF(TCFDecisionUILayer.firstLayer, UsercentricsConsentType.explicit);
                break;

            case UsercentricsVariant.ccpa:
                consents = await Usercentrics.saveOptOutForCCPA(false, UsercentricsConsentType.explicit);
                break;
        }

        applyConsents(consents);
    }

    async function denyAll() {
        if (data == undefined) return;

        let consents: [UsercentricsServiceConsent]
        switch (data.activeVariant) {
            case UsercentricsVariant.default:
                consents = await Usercentrics.denyAll(UsercentricsConsentType.explicit);
                break;
            case UsercentricsVariant.tcf:
                consents = await Usercentrics.denyAllForTCF(TCFDecisionUILayer.firstLayer, UsercentricsConsentType.explicit);
                break;

            case UsercentricsVariant.ccpa:
                consents = await Usercentrics.saveOptOutForCCPA(true, UsercentricsConsentType.explicit);
                break;
        }

        applyConsents(consents);
    }

    const decisionsExample: [UserDecision] = [
        {
            serviceId: "SJKM9Ns_ibQ",
            consent: false
        }
    ]

    const purposesExample: [TCFUserDecisionOnPurpose] = [
        {
            id: 123,
            consent: false,
            legitimateInterestConsent: true,
        }
    ]

    const specialFeaturesExample: [TCFUserDecisionOnSpecialFeature] = [
        {
            id: 222,
            consent: false,
        }
    ]

    const vendorsExample: [TCFUserDecisionOnVendor] = [
        {
            id: 111,
            consent: false,
            legitimateInterestConsent: true
        }
    ];

    async function saveServices() {
        if (data == undefined) return;

        let consents: [UsercentricsServiceConsent?]
        switch (data.activeVariant) {
            case UsercentricsVariant.default:
                consents = await Usercentrics.saveDecisions(
                    decisionsExample,
                    UsercentricsConsentType.explicit
                );
                break;
            case UsercentricsVariant.tcf:
                const tcfUserDecisions: TCFUserDecisions = {
                    purposes: purposesExample,
                    specialFeatures: specialFeaturesExample,
                    vendors: vendorsExample
                };

                consents = await Usercentrics.saveDecisionsForTCF(
                    tcfUserDecisions,
                    TCFDecisionUILayer.firstLayer,
                    decisionsExample,
                    UsercentricsConsentType.explicit
                );
                break;

            case UsercentricsVariant.ccpa:
                // NO Action for CCPA
                consents = [];
                break;
        }

        applyConsents(consents);
    }

    function applyConsents(consents: [UsercentricsServiceConsent?]) {
        // https://docs.usercentrics.com/cmp_in_app_sdk/latest/apply_consent/apply-consent/#apply-consent-to-each-service
        consents.forEach(consent => {
            console.log(`Consent: ${consent?.templateId} Status: ${consent?.status} Type: ${consent?.type}`);
        })
    }

    return (
        <View style={styles.container}>
            <Text>The label below shows what Legal Framework has been set according to your Settings ID</Text>
            <Text>{
                activeVariantTitle()
            }</Text>
            <Text>Those buttons represents APIs that you need to call in order to replicate user actions to Usercentrics</Text>
            <Button onPress={() => {
                printUIElements();
            }} title="Print UI elements" />

            <Button onPress={() => {
                acceptAll();
            }} title="Accept All" />

            <Button onPress={() => {
                denyAll();
            }} title="Deny All" />

            <Button onPress={() => {
                saveServices();
            }} title="Save Services" />

            <Button onPress={() => {
                changeLanguage();
            }} title="Change Language" />
        </View>
    );
};