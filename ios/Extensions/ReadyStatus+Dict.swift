import Foundation
import Usercentrics

public extension UsercentricsReadyStatus {
    func toDictionary() -> NSDictionary {
        return [
            "shouldCollectConsent": self.shouldCollectConsent,
            "consents": self.consents.toListOfDictionary()
        ]
    }
}
