import Foundation
import Usercentrics

extension GppSectionChangePayload {
    func toDictionary() -> NSDictionary {
        return [
            "data": self.data
        ]
    }
}
