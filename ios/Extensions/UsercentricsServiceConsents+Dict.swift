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
            "isEssential": self.isEssential,
            "history": self.history.toDictionary(),
            "category": self.category
        ]

        if let type = self.type?.ordinal {
            dict["type"] = type
        }

        return dict
    }
}

public extension Array where Element == UsercentricsConsentHistoryEntry {
    func toDictionary() -> [NSDictionary] {
        self.map {
            [
                "status": $0.status,
                "type": $0.type.ordinal,
                "timestampInMillis": $0.timestampInMillis
            ]
        }
    }
}
