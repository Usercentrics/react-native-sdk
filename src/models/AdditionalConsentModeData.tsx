export class AdditionalConsentModeData {

    acString: string
    adTechProviders: AdTechProvider[]

    constructor(
        acString: string,
        adTechProviders: AdTechProvider[]
    ) {
        this.acString = acString
        this.adTechProviders = adTechProviders
    }
}

export class AdTechProvider {

    id: number
    name: string
    privacyPolicyUrl: string
    consent: boolean

    constructor(
        id: number,
        name: string,
        privacyPolicyUrl: string,
        consent: boolean,
    ) {
        this.id = id
        this.name = name
        this.privacyPolicyUrl = privacyPolicyUrl
        this.consent = consent
    }
}
