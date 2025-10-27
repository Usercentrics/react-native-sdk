import Foundation
import Usercentrics

extension UserDecision {
  static func mockToDict() -> NSDictionary {
    let decision = UserDecision(serviceId: "abc", consent: false)
    return [
      "serviceId": decision.serviceId,
      "consent": decision.consent
    ]
  }
}
