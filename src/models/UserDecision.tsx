export class UserDecision {
    serviceId: string
    consent: boolean


    constructor(serviceId: string, consent: boolean) {
        this.serviceId = serviceId
        this.consent = consent
    }
}