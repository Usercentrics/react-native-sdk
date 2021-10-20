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
        let dict: NSMutableDictionary = [
            "templateId": self.templateId,
            "status": self.status,
            "version": self.version,
            "dataProcessor": self.dataProcessor,
        ]

        if let type = self.type?.ordinal {
            dict["type"] = type
        }

        return dict
    }
}
