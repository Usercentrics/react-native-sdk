export class ConsentDisclosureSDK {
    name: string
    use: string

    constructor(name: string, use: string) {
        this.name = name
        this.use = use
    }
}

export class ConsentDisclosureObject {

    disclosures: [ConsentDisclosure]
    sdks: ConsentDisclosureSDK[]

    constructor(disclosures: [ConsentDisclosure], sdks?: ConsentDisclosureSDK[]) {
        this.disclosures = disclosures
        this.sdks = sdks ?? []
    }
}

export class ConsentDisclosure {

    identifier?: string
    type?: ConsentDisclosureType
    name?: string
    maxAgeSeconds?: number
    cookieRefresh: boolean
    purposes: [number]
    domain?: string
    description?: string

    constructor(
        cookieRefresh: boolean,
        purposes: [number],
        identifier?: string,
        type?: ConsentDisclosureType,
        name?: string,
        maxAgeSeconds?: number,
        domain?: string,
        description?: string,
    ) {
        this.identifier = identifier
        this.type = type
        this.name = name
        this.maxAgeSeconds = maxAgeSeconds
        this.cookieRefresh = cookieRefresh
        this.purposes = purposes
        this.domain = domain
        this.description = description
    }
}

export enum ConsentDisclosureType {

    cookie = 0,
    web = 1,
    app = 2
}
