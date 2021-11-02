import Foundation
import Usercentrics

public extension UsercentricsReadyStatus {
    func toDictionary() -> NSDictionary {
        return [
            "shouldShowCMP": self.shouldShowCMP,
            "consents": self.consents.toListOfDictionary()
        ]
    }
}
