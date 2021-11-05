import Foundation
import Usercentrics

public extension UserDecision {
    convenience init?(from dict: NSDictionary) {
        guard let serviceId = dict["serviceId"] as? String,
              let consent = dict["consent"] as? Bool
        else { return nil }

        self.init(serviceId: serviceId,
                  consent: consent)
    }
}
