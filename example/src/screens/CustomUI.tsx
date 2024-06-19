import * as React from 'react';
import {Button, StyleSheet, Text, View} from 'react-native';
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
import {AdTechProviderDecision} from "../../../src/models/TCFUserDecisions";

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
        const cmpDataSettings = data.settings;

        console.log(`Title: ${cmpDataSettings.labels.firstLayerTitle}`);
        console.log(`Description: ${cmpDataSettings.firstLayerDescriptionHtml}`);

        console.log(`Accept All button: ${cmpDataSettings.labels.btnAcceptAll}`);
        console.log(`Deny button: ${cmpDataSettings.labels.btnDeny}`);
        console.log(`Save button: ${cmpDataSettings.labels.btnSave}`);

        console.log(`CMP Data settings: ${JSON.stringify(cmpDataSettings)}`);
        console.log(`CMP Data services: ${JSON.stringify(data.services)}`);*/
        console.log(`CMP Data categories: ${JSON.stringify(data.categories)}`);

        console.log(`User Country: ${data.userLocation.countryCode}`)
        console.log(`User Region: ${data.userLocation.regionCode}`)
    }

    async function printCCPA() {
        if (data == undefined) return;
        const ccpa = data.settings.ccpa;


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

    async function printTCF() {
        if (data == undefined) return;

        console.log("Set your CMP ID");
        Usercentrics.setCMPId(123);

        const tcf2 = data.settings.tcf2;

        console.log(`First layer title: ${tcf2?.firstLayerTitle}`);
        console.log(`First layer description: ${tcf2?.firstLayerDescription}`);

        console.log(`Second layer title: ${tcf2?.secondLayerTitle}`);
        console.log(`Second layer description: ${tcf2?.secondLayerDescription}`);

        const tcfData = await Usercentrics.getTCFData();
        console.log(`TCString ${tcfData.tcString}`);

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

    const decisionsExample: UserDecision[] = [
        {
            serviceId: "SJKM9Ns_ibQ",
            consent: false
        }
    ]

    const purposesExample: TCFUserDecisionOnPurpose[] = [
        {
            id: 123,
            consent: false,
            legitimateInterestConsent: true,
        }
    ]

    const specialFeaturesExample: TCFUserDecisionOnSpecialFeature[] = [
        {
            id: 222,
            consent: false,
        }
    ]

    const vendorsExample: TCFUserDecisionOnVendor[] = [
        {
            id: 111,
            consent: false,
            legitimateInterestConsent: true
        }
    ];

    const adTechProvidersExample: AdTechProviderDecision[] = [
        {
            id: 43,
            consent: false,
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
                    vendors: vendorsExample,
                    adTechProviders: adTechProvidersExample
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

    async function getConsents() {
        if (data == undefined) return;
        let consents = await Usercentrics.getConsents();
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
            }} title="Print UI elements"/>

            <Button onPress={() => {
                acceptAll();
            }} title="Accept All"/>

            <Button onPress={() => {
                denyAll();
            }} title="Deny All"/>

            <Button onPress={() => {
                saveServices();
            }} title="Save Services"/>

            <Button onPress={() => {
                getConsents();
            }} title="Get Consents"/>

            <Button onPress={() => {
                changeLanguage();
            }} title="Change Language"/>
        </View>
    );
};
