import Foundation
import UsercentricsUI

extension UsercentricsConsentUserResponse {
    func toDictionary() -> NSDictionary {
        return [
            "controllerId": self.controllerId,
            "userInteraction": self.userInteraction.toString(),
            "consents": self.consents.map { $0.toDictionary() }
        ]
    }
}
