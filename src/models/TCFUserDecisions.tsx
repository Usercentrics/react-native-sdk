export class TCFUserDecisions {
    /// A user's consent decision on TCF purposes.
    purposes: [TCFUserDecisionOnPurpose]

    /// A user's consent decision on TCF special features.
    specialFeatures: [TCFUserDecisionOnSpecialFeature]

    /// A user's consent decision on TCF vendors.
    vendors: [TCFUserDecisionOnVendor]


    constructor(purposes: [TCFUserDecisionOnPurpose], specialFeatures: [TCFUserDecisionOnSpecialFeature], vendors: [TCFUserDecisionOnVendor]) {
        this.purposes = purposes
        this.specialFeatures = specialFeatures
        this.vendors = vendors
    }
}

export class TCFUserDecisionOnPurpose {
    id: number
    consent?: boolean
    legitimateInterestConsent?: boolean


    constructor(id: number, consent?: boolean, legitimateInterestConsent?: boolean) {
        this.id = id
        this.consent = consent
        this.legitimateInterestConsent = legitimateInterestConsent
    }
}

export class TCFUserDecisionOnSpecialFeature {
    id: number
    consent?: boolean

    constructor(id: number, consent?: boolean) {
        this.id = id
        this.consent = consent
    }
}

export class TCFUserDecisionOnVendor {
    id: number
    consent?: boolean
    legitimateInterestConsent?: boolean

    constructor(id: number, consent?: boolean, legitimateInterestConsent?: boolean) {
        this.id = id
        this.consent = consent
        this.legitimateInterestConsent = legitimateInterestConsent
    }
}