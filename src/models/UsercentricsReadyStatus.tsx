import { UsercentricsServiceConsent } from "."

export class UsercentricsReadyStatus {
    shouldCollectConsent: boolean
    consents: [UsercentricsServiceConsent]

    constructor(shouldCollectConsent: boolean, consents: [UsercentricsServiceConsent]) {
        this.shouldCollectConsent = shouldCollectConsent
        this.consents = consents
    }
}