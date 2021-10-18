import { UsercentricsServiceConsent, UsercentricsUserInteraction } from "."

export class UsercentricsConsentUserResponse { 
    controllerId: string
    userInteraction: UsercentricsUserInteraction
    consents: [UsercentricsServiceConsent]

    constructor(controllerId: string, userIntaction: UsercentricsUserInteraction, consents: [UsercentricsServiceConsent]) { 
        this.controllerId = controllerId;
        this.userInteraction = userIntaction
        this.consents = consents
    } 
}