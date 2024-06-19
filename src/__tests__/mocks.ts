import {
    CCPASettings,
    ConsentDisclosure,
    ConsentDisclosureObject,
    ConsentDisclosureType,
    DpsDisplayFormat,
    FirstLayer,
    FirstLayerMobileVariant,
    TCF2ChangedPurposes,
    TCF2Scope,
    TCF2Settings,
    TCFUserDecisionOnPurpose,
    TCFUserDecisionOnSpecialFeature,
    TCFUserDecisionOnVendor,
    USAFrameworks, UsercentricsCategory,
    UsercentricsCMPData,
    UsercentricsLabels, UsercentricsLocation,
    UsercentricsSettings,
    UsercentricsVariant
} from "../models";
import { TCFFeature, TCFPurpose } from "../models/TCFData";
import { AdTechProviderDecision } from "../models/TCFUserDecisions";
import { UsercentricsService } from "../models/UsercentricsService";

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

const ucLabels: UsercentricsLabels = {
    btnAcceptAll: "btnAcceptAll",
    btnDeny: "btnDeny",
    btnSave: "btnSave",
    firstLayerTitle: "firstLayerTitle",
    accepted: "accepted",
    denied: "denied",
    date: "date",
    decision: "decision",
    dataCollectedList: "dataCollectedList",
    dataCollectedInfo: "dataCollectedInfo",
    locationOfProcessing: "locationOfProcessing",
    transferToThirdCountries: "transferToThirdCountries",
    dataPurposes: "dataPurposes",
    dataPurposesInfo: "dataPurposesInfo",
    dataRecipientsList: "dataRecipientsList",
    descriptionOfService: "descriptionOfService",
    history: "history",
    historyDescription: "historyDescription",
    legalBasisList: "legalBasisList",
    legalBasisInfo: "legalBasisInfo",
    processingCompanyTitle: "processingCompanyTitle",
    retentionPeriod: "retentionPeriod",
    technologiesUsed: "technologiesUsed",
    technologiesUsedInfo: "technologiesUsedInfo",
    cookiePolicyInfo: "cookiePolicyInfo",
    optOut: "optOut",
    policyOf: "policyOf",
    imprintLinkText: "imprintLinkText",
    privacyPolicyLinkText: "privacyPolicyLinkText",
    categories: "categories",
    anyDomain: "anyDomain",
    day: "day",
    days: "days",
    domain: "domain",
    duration: "duration",
    informationLoadingNotPossible: "informationLoadingNotPossible",
    hour: "hour",
    hours: "hours",
    identifier: "identifier",
    maximumAgeCookieStorage: "maximumAgeCookieStorage",
    minute: "minute",
    minutes: "minutes",
    month: "month",
    months: "months",
    multipleDomains: "multipleDomains",
    no: "no",
    nonCookieStorage: "nonCookieStorage",
    seconds: "seconds",
    session: "session",
    loadingStorageInformation: "loadingStorageInformation",
    storageInformation: "storageInformation",
    detailedStorageInformation: "detailedStorageInformation",
    tryAgain: "tryAgain",
    type: "type",
    year: "year",
    years: "years",
    yes: "yes",
    storageInformationDescription: "storageInformationDescription",
    btnBannerReadMore: "btnBannerReadMore",
    linkToDpaInfo: "linkToDpaInfo",
    second: "second",
    consent: "consent",
    secondLayerDescriptionHtml: "secondLayerDescriptionHtml",
    secondLayerTitle: "secondLayerTitle",
    btnMore: "btnMore",
    explicit: "explicit",
    transferToThirdCountriesInfo: "transferToThirdCountriesInfo",
    more: "more",
    headerModal: "headerModal",
    furtherInformationOptOut: "furtherInformationOptOut",
    cookiePolicyLinkText: "cookiePolicyLinkText",
    noImplicit: "noImplicit",
    yesImplicit: "yesImplicit",
}

const ccpaSettings: CCPASettings = {
    optOutNoticeLabel: "optOutNoticeLabel",
    btnSave: "btnSave",
    firstLayerTitle: "firstLayerTitle",
    isActive: true,
    showOnPageLoad: true,
    reshowAfterDays: 90,
    iabAgreementExists: true,
    appFirstLayerDescription: "appFirstLayerDescription",
    firstLayerMobileDescriptionIsActive: true,
    firstLayerMobileDescription: "firstLayerMobileDescription",
    secondLayerTitle: "secondLayerTitle",
    secondLayerDescription: "secondLayerDescription",
    secondLayerHideLanguageSwitch: true,
    btnMoreInfo: "btnMoreInfo",
}

const tcf2ChangedPurposes: TCF2ChangedPurposes = {
    legIntPurposes: [1],
    purposes: [2]
}

const tcf2Settings: TCF2Settings = {
    firstLayerTitle: "firstLayerTitle",
    secondLayerTitle: "secondLayerTitle",
    tabsPurposeLabel: "tabsPurposeLabel",
    tabsVendorsLabel: "tabsVendorsLabel",
    labelsFeatures: "labelsFeatures",
    labelsIabVendors: "labelsIabVendors",
    labelsNonIabPurposes: "labelsNonIabPurposes",
    labelsNonIabVendors: "labelsNonIabVendors",
    labelsPurposes: "labelsPurposes",
    vendorFeatures: "vendorFeatures",
    vendorLegitimateInterestPurposes: "vendorLegitimateInterestPurposes",
    vendorPurpose: "vendorPurpose",
    vendorSpecialFeatures: "vendorSpecialFeatures",
    vendorSpecialPurposes: "vendorSpecialPurposes",
    togglesConsentToggleLabel: "togglesConsentToggleLabel",
    togglesLegIntToggleLabel: "togglesLegIntToggleLabel",
    buttonsAcceptAllLabel: "buttonsAcceptAllLabel",
    buttonsDenyAllLabel: "buttonsDenyAllLabel",
    buttonsSaveLabel: "buttonsSaveLabel",
    linksManageSettingsLabel: "linksManageSettingsLabel",
    linksVendorListLinkLabel: "linksVendorListLinkLabel",
    cmpId: 1,
    cmpVersion: 1,
    firstLayerHideToggles: true,
    secondLayerHideToggles: true,
    hideLegitimateInterestToggles: true,
    firstLayerHideButtonDeny: true,
    secondLayerHideButtonDeny: true,
    publisherCountryCode: "",
    purposeOneTreatment: true,
    selectedVendorIds: [755],
    gdprApplies: true,
    selectedStacks: [1],
    disabledSpecialFeatures: [1],
    firstLayerShowDescriptions: true,
    hideNonIabOnFirstLayer: true,
    resurfacePeriodEnded: true,
    resurfacePurposeChanged: true,
    resurfaceVendorAdded: true,
    firstLayerDescription: "firstLayerDescription",
    firstLayerAdditionalInfo: "firstLayerAdditionalInfo",
    secondLayerDescription: "secondLayerDescription",
    togglesSpecialFeaturesToggleOn: "togglesSpecialFeaturesToggleOn",
    togglesSpecialFeaturesToggleOff: "togglesSpecialFeaturesToggleOff",
    appLayerNoteResurface: "appLayerNoteResurface",
    firstLayerNoteResurface: "firstLayerNoteResurface",
    categoriesOfDataLabel: "categoriesOfDataLabel",
    dataRetentionPeriodLabel: "dataRetentionPeriodLabel",
    legitimateInterestLabel: "legitimateInterestLabel",
    version: "version",
    examplesLabel: "examplesLabel",
    firstLayerMobileVariant: FirstLayerMobileVariant.full,
    showDataSharedOutsideEUText: true,
    dataSharedOutsideEUText: "dataSharedOutsideEUText",
    vendorIdsOutsideEUList: [1],
    scope: TCF2Scope.global,
    changedPurposes: tcf2ChangedPurposes,
    acmV2Enabled: true,
    selectedATPIds: [10, 20, 30]
}

const firstLayer: FirstLayer = {
    hideButtonDeny: false
}

const ucSettings: UsercentricsSettings = {
    labels: ucLabels,
    version: "2.2",
    language: "en",
    imprintUrl: "url",
    privacyPolicyUrl: "privacyPolicyUrl",
    cookiePolicyUrl: "cookiePolicyUrl",
    firstLayerDescriptionHtml: "firstLayerDescriptionHtml",
    firstLayerMobileDescriptionHtml: "firstLayerMobileDescriptionHtml",
    settingsId: "someId",
    bannerMobileDescriptionIsActive: true,
    enablePoweredBy: true,
    displayOnlyForEU: true,
    tcf2Enabled: true,
    reshowBanner: 1,
    editableLanguages: ["en"],
    languagesAvailable: ["en"],
    showInitialViewForVersionChange: ["a"],
    ccpa: ccpaSettings,
    tcf2: tcf2Settings,
    customization: "custom",
    firstLayer: firstLayer,
    secondLayer: undefined,
    variants: undefined,
    dpsDisplayFormat: DpsDisplayFormat.all,
    framework: USAFrameworks.cpa,
    publishedApps: undefined
}

const disclosure: ConsentDisclosure = {
    identifier: "identifier",
    type: ConsentDisclosureType.app,
    name: "name",
    maxAgeSeconds: 0,
    cookieRefresh: false,
    purposes: [0],
    domain: "domain",
    description: "description",
}

const consentDisclosureObject: ConsentDisclosureObject = {
    disclosures: [disclosure]
}

const ucService: UsercentricsService = {
    templateId: "templateId",
    version: "version",
    categorySlug: "categorySlug",
    isEssential: true,
    type: "type",
    dataProcessor: "dataProcessor",
    dataPurposes: ["dataPurposes"],
    processingCompany: "processingCompany",
    nameOfProcessingCompany: "nameOfProcessingCompany",
    addressOfProcessingCompany: "addressOfProcessingCompany",
    descriptionOfService: "descriptionOfService",
    languagesAvailable: ["languagesAvailable"],
    dataCollectedList: ["dataCollectedList"],
    dataPurposesList: ["dataPurposesList"],
    dataRecipientsList: ["dataRecipientsList"],
    legalBasisList: ["legalBasisList"],
    retentionPeriodList: ["retentionPeriodList"],
    subConsents: ["subConsents"],
    language: "language",
    linkToDpa: "linkToDpa",
    legalGround: "legalGround",
    optOutUrl: "optOutUrl",
    policyOfProcessorUrl: "policyOfProcessorUrl",
    retentionPeriodDescription: "retentionPeriodDescription",
    dataProtectionOfficer: "dataProtectionOfficer",
    privacyPolicyURL: "privacyPolicyURL",
    cookiePolicyURL: "cookiePolicyURL",
    locationOfProcessing: "locationOfProcessing",
    dataCollectedDescription: "dataCollectedDescription",
    thirdCountryTransfer: "thirdCountryTransfer",
    description: "description",
    cookieMaxAgeSeconds: 100,
    usesNonCookieAccess: true,
    deviceStorageDisclosureUrl: "deviceStorageDisclosureUrl",
    technologyUsed: ["technologyUsed"],
    isDeactivated: true,
    disableLegalBasis: true,
    deviceStorage: consentDisclosureObject,
    isHidden: true,
};

const ucCategory : UsercentricsCategory = {
    categorySlug: "categorySlug",
    description: "description",
    isEssential: false,
    label: "label"
}

const userLocation: UsercentricsLocation = {
    countryCode: "PT",
    isInCalifornia: false,
    isInEU: true,
    isInUS: false,
    regionCode: "PT11"
}

export const cmpDataExample: UsercentricsCMPData = {
    settings: ucSettings,
    services: [ucService],
    categories: [ucCategory],
    activeVariant: UsercentricsVariant.default,
    userLocation: userLocation
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
