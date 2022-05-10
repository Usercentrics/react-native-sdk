import { TCFUserDecisionOnPurpose, TCFUserDecisionOnSpecialFeature, TCFUserDecisionOnVendor, UsercentricsCMPData, UsercentricsVariant } from "../models";
import { TCFFeature, TCFPurpose } from "../models/TCFData";

export const usercentricsServiceConsent = {
    templateId: "abc",
    status: false,
    dataProcessor: "abc",
    version: "abc",
    type: 0
};

export const userDecision = {
    serviceId: "1",
    consent: false
};

export const ccpaDataExample = {
    uspString: "ABCD1234",
    version: 123,
    optedOut: false,
    lspact: true,
    noticeGiven: false
}

export const cmpDataExample: UsercentricsCMPData = {
    settings: undefined,
    services: [undefined],
    categories: [undefined],
    activeVariant: UsercentricsVariant.default,
    userLocation: undefined
}

export const featuresExample: [TCFFeature] = [
    {
        purposeDescription: "string",
        descriptionLegal: "string",
        id: 123,
        name: "string"
    }
]

export const purposesExample: [TCFPurpose] = [
    {
        purposeDescription: "string",
        descriptionLegal: "string",
        id: 123,
        name: "string",
        isPartOfASelectedStack: false,
        showConsentToggle: false,
        showLegitimateInterestToggle: false
    }
]

export const tcfUserDecisionOnPurposeExample: [TCFUserDecisionOnPurpose] = [
    {
        id: 123,
        consent: false,
        legitimateInterestConsent: true,
    }
];


export const tcfUserDecisionOnSpecialFeatureExample: [TCFUserDecisionOnSpecialFeature] = [
    {
        id: 222,
        consent: false,
    }
];

export const tcfUserDecisionOnVendorExample: [TCFUserDecisionOnVendor] = [
    {
        id: 111,
        consent: false,
        legitimateInterestConsent: true
    }
];
