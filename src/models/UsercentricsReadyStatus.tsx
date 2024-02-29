import {UsercentricsLocation, UsercentricsServiceConsent} from "."
import {GeolocationRuleset} from "./GeolocationRuleset";

export class UsercentricsReadyStatus {

    shouldCollectConsent: boolean
    consents: [UsercentricsServiceConsent]
    geolocationRuleset?: GeolocationRuleset;
    location: UsercentricsLocation;

    constructor(shouldCollectConsent: boolean,
                consents: [UsercentricsServiceConsent],
                location: UsercentricsLocation,
                geolocationRuleSet?: GeolocationRuleset,) {
        this.shouldCollectConsent = shouldCollectConsent
        this.consents = consents
        this.geolocationRuleset = geolocationRuleSet
        this.location = location
    }
}
