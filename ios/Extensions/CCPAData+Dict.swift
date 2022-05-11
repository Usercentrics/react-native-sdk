import Foundation
import Usercentrics

extension CCPAData {
    func toDictionary() -> NSDictionary {
        return [
            "uspString": self.toUSPString(),
            "version": self.version,
            "noticeGiven": self.noticeGiven?.boolValue as Any,
            "optedOut": self.optedOut?.boolValue as Any,
            "lspact": self.lspact?.boolValue as Any
        ]
    }
}
