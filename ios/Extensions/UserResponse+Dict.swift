import Foundation
import UsercentricsUI

public extension UsercentricsConsentUserResponse {
    func toDictionary() -> NSDictionary {
        return [
            "controllerId": self.controllerId,
            "userInteraction": self.userInteraction.toInt(),
            "consents": self.consents.toListOfDictionary()
        ]
    }
}
