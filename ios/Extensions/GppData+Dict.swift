import Foundation
import Usercentrics

extension GppData {
    func toDictionary() -> NSDictionary {
        return [
            "gppString": self.gppString,
            "applicableSections": self.applicableSections,
            "sections": self.sections,
        ]
    }
}
