import {TCFUserDecisionOnPurpose, TCFUserDecisionOnSpecialFeature, TCFUserDecisionOnVendor, UsercentricsCMPData, UsercentricsVariant} from "../models";
import {TCFFeature, TCFPurpose} from "../models/TCFData";
import {AdTechProviderDecision} from "../models/TCFUserDecisions";

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
        illustrations: ['1'],
        id: 123,
        name: "string"
    }
]

export const purposesExample: [TCFPurpose] = [
    {
        purposeDescription: "string",
        illustrations: ['1'],
        id: 123,
        name: "string",
        isPartOfASelectedStack: false,
        showConsentToggle: false,
        showLegitimateInterestToggle: false,
        legitimateInterestConsent: false,
        consent: true,
        stackId: 42,
        numberOfVendors: 1,
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

export const adTechProviderDecisionExample: [AdTechProviderDecision] = [
    {
        id: 43,
        consent: false,
    }
];
