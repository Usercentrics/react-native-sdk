import Foundation
import Usercentrics

extension TCFUserDecisions {
  static func mock() -> TCFUserDecisions {
    return TCFUserDecisions(purposes: [.mock()],
                            specialFeatures: [.mock()],
                            vendors: [.mock()],
                            adTechProviders: [.mock()])
  }

  static func mockToDict() -> NSDictionary {
    let decisions = TCFUserDecisions.mock()
    return [
      "purposes": decisions.purposes?.map { $0.toDictionary() } as Any,
      "specialFeatures": decisions.specialFeatures?.map { $0.toDictionary() } as Any,
      "vendors": decisions.vendors?.map { $0.toDictionary() } as Any,
      "adTechProviders": decisions.adTechProviders.map { $0.toDictionary() } as Any
    ]
  }
}

extension TCFUserDecisionOnPurpose {
  static func mock() -> TCFUserDecisionOnPurpose {
    return .init(id: Int32(1),
                 consent: KotlinBoolean(bool: false),
                 legitimateInterestConsent: KotlinBoolean(bool: false))
  }

  func toDictionary() -> NSDictionary {
    return [
      "id": self.id as Any,
      "consent": self.consent?.boolValue as Any,
      "legitimateInterestConsent": self.legitimateInterestConsent?.boolValue as Any
    ]
  }
}

extension TCFUserDecisionOnSpecialFeature {
  static func mock() -> TCFUserDecisionOnSpecialFeature {
    return .init(id: Int32(1),
                 consent: KotlinBoolean(bool: false))
  }

  func toDictionary() -> NSDictionary {
    return [
      "id": self.id as Any,
      "consent": self.consent?.boolValue as Any
    ]
  }
}

extension TCFUserDecisionOnVendor {
  static func mock() -> TCFUserDecisionOnVendor {
    return .init(id: Int32(1),
                 consent: KotlinBoolean(bool: false),
                 legitimateInterestConsent: KotlinBoolean(bool: false))
  }

  func toDictionary() -> NSDictionary {
    return [
      "id": self.id as Any,
      "consent": self.consent?.boolValue as Any,
      "legitimateInterestConsent": self.legitimateInterestConsent?.boolValue as Any
    ]
  }
}

extension AdTechProviderDecision {
  static func mock() -> AdTechProviderDecision {
    return .init(id: Int32(1), consent: true)
  }

  func toDictionary() -> NSDictionary {
    return [
      "id": self.id as Any,
      "consent": self.consent
    ]
  }
}
