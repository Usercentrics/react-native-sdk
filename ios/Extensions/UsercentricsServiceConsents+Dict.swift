import Foundation
import Usercentrics

public extension Array where Element: UsercentricsServiceConsent {
    func toListOfDictionary() -> [NSDictionary] {
        return self.map { $0.toDictionary() }
    }
}

public extension UsercentricsServiceConsent {
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
