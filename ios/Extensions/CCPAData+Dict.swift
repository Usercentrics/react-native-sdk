import Foundation
import Usercentrics

extension CCPAData {
    func toDictionary() -> NSDictionary {
        return [
            "version": self.version,
            "noticeGiven": self.noticeGiven?.boolValue as Any,
            "optedOut": self.optedOut?.boolValue as Any,
            "lspact": self.lspact?.boolValue as Any
        ]
    }
}
