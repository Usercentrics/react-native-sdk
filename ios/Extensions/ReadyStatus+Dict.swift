import Foundation
import Usercentrics

extension UsercentricsReadyStatus {
    func toDictionary() -> NSDictionary {
        return [
            "shouldShowCMP": self.shouldShowCMP,
            "consents": self.consents.map { $0.toDictionary() }
        ]
    }
}

extension UsercentricsServiceConsent {
    func toDictionary() -> NSDictionary {
        return [
            "templateId": self.templateId,
            "status": self.status,
            "type": self.type?.name as Any,
            "version": self.version,
            "dataProcessor": self.dataProcessor,
        ]
    }
}
