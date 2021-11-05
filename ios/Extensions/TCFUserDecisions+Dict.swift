import Foundation
import Usercentrics

public extension TCFUserDecisions {
    convenience init(from dict: NSDictionary) {
        let purposes = dict["purposes"] as? [NSDictionary]
        let specialFeatures = dict["specialFeatures"] as? [NSDictionary]
        let vendors = dict["vendors"] as? [NSDictionary]

        self.init(purposes: purposes?.compactMap { TCFUserDecisionOnPurpose(from: $0) },
                  specialFeatures: specialFeatures?.compactMap { TCFUserDecisionOnSpecialFeature(from: $0) },
                  vendors: vendors?.compactMap { TCFUserDecisionOnVendor(from: $0) })
    }
}

extension TCFUserDecisionOnPurpose {
    convenience init?(from dict: NSDictionary) {
        guard let id = dict["id"] as? Int else { return nil }

        var consent: KotlinBoolean?
        if let consentBool = dict["consent"] as? Bool {
            consent = KotlinBoolean(bool: consentBool)
        }

        var legitimateInterestConsent: KotlinBoolean?
        if let legInterestBool = dict["legitimateInterestConsent"] as? Bool {
            legitimateInterestConsent = KotlinBoolean(bool: legInterestBool)
        }

        self.init(id: Int32(id),
                  consent: consent,
                  legitimateInterestConsent: legitimateInterestConsent)
    }
}

extension TCFUserDecisionOnSpecialFeature {
    convenience init?(from dict: NSDictionary) {
        guard let id = dict["id"] as? Int else { return nil }

        var consent: KotlinBoolean?
        if let consentBool = dict["consent"] as? Bool {
            consent = KotlinBoolean(bool: consentBool)
        }

        self.init(id: Int32(id),
                  consent: consent)
    }
}

extension TCFUserDecisionOnVendor {
    convenience init?(from dict: NSDictionary) {
        guard let id = dict["id"] as? Int else { return nil }

        var consent: KotlinBoolean?
        if let consentBool = dict["consent"] as? Bool {
            consent = KotlinBoolean(bool: consentBool)
        }

        var legitimateInterestConsent: KotlinBoolean?
        if let legInterestBool = dict["legitimateInterestConsent"] as? Bool {
            legitimateInterestConsent = KotlinBoolean(bool: legInterestBool)
        }

        self.init(id: Int32(id),
                  consent: consent,
                  legitimateInterestConsent: legitimateInterestConsent)
    }
}
