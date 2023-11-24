import {ConsentDisclosureObject} from "./ConsentDisclosureObject";

export class TCFData {
    /// A list of all the TCF features that need to be disclosed to the end-user if TCF is enabled.
    features: TCFFeature[]

    /// A list of all the TCF purposes that need to be disclosed to the end-user if TCF is enabled.
    purposes: TCFPurpose[]

    /// A list of all the TCF special features that need to be disclosed to the end-user if TCF is enabled
    specialFeatures: TCFSpecialFeature[]

    /// A list of all the TCF special purposes that need to be disclosed to the end-user if TCF is enabled
    specialPurposes: TCFSpecialPurpose[]

    /// A list of all TCF stacks that need to be disclosed to the end-user if TCF is enabled. On the first layer of a
    /// TCF UI, stacks may be shown as alternative its comprising purposes and special features. However, on the second
    /// layer, this is not allowed according to the IAB TCF v.2.0 guidelines. Also on the first layer, a purpose or special
    /// feature may not be shown if a stack containing this purpose or special feature is already displayed. Note, that all
    /// purposes and special features that are part of stacks will still be listed in the TCFData purposes and special
    /// features fields, but they will be flagged with isPartOfASelectedStack = true and include a non-null stackId.
    stacks: TCFStack[]

    /// A list of all TCF vendors that need to be disclosed to the end-user if TCF is enabled */
    vendors: TCFVendor[]

    /// The TCF string
    tcString: String

    /// The total of vendors and services
    thirdPartyCount: number

    constructor(
        features: TCFFeature[],
        purposes: TCFPurpose[],
        specialFeatures: TCFSpecialFeature[],
        specialPurposes: TCFSpecialPurpose[],
        stacks: TCFStack[],
        vendors: TCFVendor[],
        tcString: String,
        thirdPartyCount: number
    ) {
        this.features = features
        this.purposes = purposes
        this.specialFeatures = specialFeatures
        this.specialPurposes = specialPurposes
        this.stacks = stacks
        this.vendors = vendors
        this.tcString = tcString
        this.thirdPartyCount = thirdPartyCount
    }
}

export class TCFFeature {
    purposeDescription: string
    illustrations: [string]
    id: number
    name: string


    constructor(
        purposeDescription: string,
        illustrations: [string],
        id: number,
        name: string
    ) {
        this.purposeDescription = purposeDescription
        this.illustrations = illustrations
        this.id = id
        this.name = name
    }
}

export class TCFPurpose {
    purposeDescription: string
    illustrations: [string]
    id: number
    name: string
    consent?: boolean
    isPartOfASelectedStack: boolean
    legitimateInterestConsent?: boolean
    showConsentToggle: boolean
    showLegitimateInterestToggle: boolean
    stackId?: number


    constructor(
        purposeDescription: string,
        illustrations: [string],
        id: number,
        name: string,
        isPartOfASelectedStack: boolean,
        showConsentToggle: boolean,
        showLegitimateInterestToggle: boolean,
        legitimateInterestConsent?: boolean,
        consent?: boolean,
        stackId?: number
    ) {
        this.purposeDescription = purposeDescription
        this.illustrations = illustrations
        this.id = id
        this.name = name
        this.consent = consent
        this.isPartOfASelectedStack = isPartOfASelectedStack
        this.legitimateInterestConsent = legitimateInterestConsent
        this.showConsentToggle = showConsentToggle
        this.showLegitimateInterestToggle = showLegitimateInterestToggle
        this.stackId = stackId
    }
}

export class TCFSpecialFeature {
    purposeDescription: string
    illustrations: [string]
    id: number
    name: string
    consent?: boolean
    isPartOfASelectedStack: boolean
    stackId?: number
    showConsentToggle: boolean


    constructor(
        purposeDescription: string,
        illustrations: [string],
        id: number,
        isPartOfASelectedStack: boolean,
        showConsentToggle: boolean,
        name: string,
        consent?: boolean,
        stackId?: number
    ) {
        this.purposeDescription = purposeDescription
        this.illustrations = illustrations
        this.id = id
        this.name = name
        this.consent = consent
        this.isPartOfASelectedStack = isPartOfASelectedStack
        this.stackId = stackId
        this.showConsentToggle = showConsentToggle
    }

}

export class TCFSpecialPurpose {
    purposeDescription: string
    illustrations: [string]
    id: number
    name: string


    constructor(
        purposeDescription: string,
        illustrations: [string],
        id: number,
        name: string
    ) {
        this.purposeDescription = purposeDescription
        this.illustrations = illustrations
        this.id = id
        this.name = name
    }
}

export class TCFStack {
    description: string
    id: number
    name: string
    purposeIds: [number]
    specialFeatureIds: [number]


    constructor(
        description: string,
        id: number,
        name: string,
        purposeIds: [number],
        specialFeatureIds: [number]
    ) {
        this.description = description
        this.id = id
        this.name = name
        this.purposeIds = purposeIds
        this.specialFeatureIds = specialFeatureIds
    }

}

export class TCFVendor {
    consent?: boolean
    features: [number]
    flexiblePurposes: [number]
    id: number
    legitimateInterestConsent?: boolean
    legitimateInterestPurposes: [number]
    name: string
    policyUrl: string
    purposes: [number]
    specialFeatures: [number]
    specialPurposes: [number]
    showConsentToggle: boolean
    showLegitimateInterestToggle: boolean
    cookieMaxAgeSeconds: number
    usesNonCookieAccess: boolean
    deviceStorageDisclosureUrl?: string
    usesCookies: boolean
    cookieRefresh?: boolean
    dataSharedOutsideEU: boolean
    dataCategories: [number]
    vendorUrls: VendorUrl[]
    deviceStorage?: ConsentDisclosureObject

    constructor(
        features: [number],
        flexiblePurposes: [number],
        id: number,
        legitimateInterestPurposes: [number],
        name: string,
        policyUrl: string,
        purposes: [number],
        specialFeatures: [number],
        specialPurposes: [number],
        showConsentToggle: boolean,
        showLegitimateInterestToggle: boolean,
        cookieMaxAgeSeconds: number,
        usesNonCookieAccess: boolean,
        usesCookies: boolean,
        dataSharedOutsideEU: boolean,
        dataCategories: [number],
        vendorUrls: VendorUrl[],
        deviceStorageDisclosureUrl?: string,
        legitimateInterestConsent?: boolean,
        consent?: boolean,
        cookieRefresh?: boolean,
        deviceStorage?: ConsentDisclosureObject
    ) {
        this.consent = consent
        this.features = features
        this.flexiblePurposes = flexiblePurposes
        this.id = id
        this.legitimateInterestConsent = legitimateInterestConsent
        this.legitimateInterestPurposes = legitimateInterestPurposes
        this.name = name
        this.policyUrl = policyUrl
        this.purposes = purposes
        this.specialFeatures = specialFeatures
        this.specialPurposes = specialPurposes
        this.showConsentToggle = showConsentToggle
        this.showLegitimateInterestToggle = showLegitimateInterestToggle
        this.cookieMaxAgeSeconds = cookieMaxAgeSeconds
        this.usesNonCookieAccess = usesNonCookieAccess
        this.deviceStorageDisclosureUrl = deviceStorageDisclosureUrl
        this.usesCookies = usesCookies
        this.cookieRefresh = cookieRefresh
        this.dataSharedOutsideEU = dataSharedOutsideEU
        this.dataCategories = dataCategories
        this.vendorUrls = vendorUrls
        this.deviceStorage = deviceStorage
    }
}

export class VendorUrl {
    langId?: string
    privacy?: string
    legIntClaim?: string

    constructor(
        langId: string,
        privacy: string,
        legIntClaim: string
    ) {
        this.langId = langId
        this.privacy = privacy
        this.legIntClaim = legIntClaim
    }

}
