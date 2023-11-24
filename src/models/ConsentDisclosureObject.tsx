export class ConsentDisclosureObject {

    disclosures: [ConsentDisclosure]

    constructor(disclosures: [ConsentDisclosure]) {
        this.disclosures = disclosures
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
    cookie,
    web,
    app
}
