import Foundation
import Usercentrics

public extension UsercentricsReadyStatus {
    func toDictionary() -> NSDictionary {
        return [
            "shouldCollectConsent": self.shouldCollectConsent,
            "consents": self.consents.toListOfDictionary(),
            "geolocationRuleset": self.geolocationRuleset?.toDictionary(),
            "location": location.toDictionary()
        ]
    }
}

public extension GeolocationRuleset {
    func toDictionary() -> NSDictionary {
        return [
            "activeSettingsId": self.activeSettingsId,
            "bannerRequiredAtLocation": self.bannerRequiredAtLocation
        ]
    }
}
