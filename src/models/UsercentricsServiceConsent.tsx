import { UsercentricsConsentType } from "."

export class UsercentricsServiceConsent { 
    templateId: string
    status: boolean
    dataProcessor: string
    version: string
    type: UsercentricsConsentType

    constructor(templateId: string, status: boolean, dataProcessor: string, version: string, type: UsercentricsConsentType) {
        this.templateId = templateId
        this.status = status
        this.dataProcessor = dataProcessor
        this.version = version
        this.type = type
    }    
}