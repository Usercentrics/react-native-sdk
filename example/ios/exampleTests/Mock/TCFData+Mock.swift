import Foundation
import Usercentrics

extension TCFData {
  static func mock() -> TCFData {
    return .init(features: [.mock()],
                 purposes: [.mock()],
                 specialFeatures: [.mock()],
                 specialPurposes: [.mock()],
                 stacks: [.mock()],
                 vendors: [.mock()])
  }
}

extension TCFFeature {
  static func mock() -> TCFFeature {
    return .init(purposeDescription: "abc",
                 descriptionLegal: "abc",
                 id: Int32(123),
                 name: "abc")
  }
}

extension TCFPurpose {
  static func mock() -> TCFPurpose {
    return .init(purposeDescription: "abc",
                 descriptionLegal: "abc",
                 id: Int32(123),
                 name: "abc",
                 consent: KotlinBoolean(bool: false),
                 isPartOfASelectedStack: false,
                 legitimateInterestConsent: KotlinBoolean(bool: false),
                 showConsentToggle: false,
                 showLegitimateInterestToggle: false,
                 stackId: KotlinInt(int: Int32(123)))
  }
}

extension TCFSpecialFeature {
  static func mock() -> TCFSpecialFeature {
    return .init(purposeDescription: "abc",
                 descriptionLegal: "abc",
                 id: Int32(123),
                 name: "abc",
                 consent: KotlinBoolean(bool: false),
                 isPartOfASelectedStack: false,
                 stackId: KotlinInt(int: Int32(123)),
                 showConsentToggle: false)
  }
}

extension TCFStack {
  static func mock() -> TCFStack {
    return .init(description: "abc",
                 id: Int32(123),
                 name: "abc",
                 purposeIds: [],
                 specialFeatureIds: [])
  }
}

extension TCFSpecialPurpose {
  static func mock() -> TCFSpecialPurpose {
    return .init(purposeDescription: "abc",
                 descriptionLegal: "abc",
                 id: Int32(123),
                 name: "abc")
  }
}

extension TCFVendor {
  static func mock() -> TCFVendor {
    return .init(consent: KotlinBoolean(bool: false),
                 features: [.init(id: Int32(123), name: "abc")],
                 flexiblePurposes:  [.init(id: Int32(123), name: "abc")],
                 id: Int32(123),
                 legitimateInterestConsent: KotlinBoolean(bool: false),
                 legitimateInterestPurposes:  [.init(id: Int32(123), name: "abc")],
                 name: "abc",
                 policyUrl: "abc",
                 purposes:  [.init(id: Int32(123), name: "abc")],
                 restrictions: [],
                 specialFeatures:  [.init(id: Int32(123), name: "abc")],
                 specialPurposes:  [.init(id: Int32(123), name: "abc")],
                 showConsentToggle: false,
                 showLegitimateInterestToggle: false,
                 cookieMaxAgeSeconds: nil,
                 usesNonCookieAccess: false,
                 deviceStorageDisclosureUrl: "abc",
                 deviceStorage: nil,
                 usesCookies: false,
                 cookieRefresh: KotlinBoolean(bool: false))
  }
}
