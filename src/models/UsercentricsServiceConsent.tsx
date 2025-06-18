import {UsercentricsConsentType} from "."

export class UsercentricsServiceConsent {

    templateId: string
    status: boolean
    dataProcessor: string
    version: string
    type: UsercentricsConsentType
    isEssential: boolean
    history: UsercentricsConsentHistoryEntry[]
    category: string

    constructor(templateId: string, status: boolean, dataProcessor: string, version: string, type: UsercentricsConsentType, isEssential: boolean, history: UsercentricsConsentHistoryEntry[], category: string) {
        this.templateId = templateId
        this.status = status
        this.dataProcessor = dataProcessor
        this.version = version
        this.type = type
        this.isEssential = isEssential
        this.history = history
        this.category = category;
    }
}

export class UsercentricsConsentHistoryEntry {

    status: boolean
    type: UsercentricsConsentType
    timestampInMillis: number

    constructor(status: boolean, type: UsercentricsConsentType, timestampInMillis: number) {
        this.status = status;
        this.type = type;
        this.timestampInMillis = timestampInMillis;
    }
}
