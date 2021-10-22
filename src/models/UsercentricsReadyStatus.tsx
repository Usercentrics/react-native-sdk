import { UsercentricsServiceConsent } from "."

export class UsercentricsReadyStatus {
    shouldShowCMP: boolean
    consents: [UsercentricsServiceConsent]

    constructor(shouldShowCMP: boolean, consents: [UsercentricsServiceConsent]) {
        this.shouldShowCMP = shouldShowCMP
        this.consents = consents
    }
}