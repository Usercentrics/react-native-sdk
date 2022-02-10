import Foundation
import Usercentrics

extension TCFData {
    func toDictionary()-> Any {
        return[
            "features" : features.map { $0.toDictionary() },
            "purposes" : purposes.map { $0.toDictionary() },
            "specialFeatures" : specialFeatures.map { $0.toDictionary() },
            "specialPurposes" : specialPurposes.map { $0.toDictionary() },
            "stacks" : stacks.map { $0.toDictionary() },
            "vendors" : vendors.map { $0.toDictionary() }
        ]
    }
}

extension TCFFeature {
    func toDictionary() -> NSDictionary {
        return[
            "purposeDescription" : purposeDescription,
            "descriptionLegal" : descriptionLegal,
            "id" : id,
            "name" : name,
        ]
    }
}

extension TCFPurpose {
    func toDictionary() -> NSDictionary {
        return[
            "purposeDescription" : purposeDescription,
            "descriptionLegal" : descriptionLegal,
            "id" : id,
            "name" : name,
            "consent" : consent?.boolValue as Any,
            "isPartOfASelectedStack" : isPartOfASelectedStack,
            "legitimateInterestConsent" : self.legitimateInterestConsent?.boolValue as Any,
            "showConsentToggle" : showConsentToggle,
            "showLegitimateInterestToggle" : showLegitimateInterestToggle,
            "stackId" : stackId as Any,
        ]
    }
}

extension TCFSpecialPurpose {
    func toDictionary() -> NSDictionary {
        return[
            "purposeDescription" : purposeDescription,
            "descriptionLegal" : descriptionLegal,
            "id" : id,
            "name" : name,
        ]
    }
}


extension TCFSpecialFeature {

    func toDictionary() -> NSDictionary {
        return[
            "purposeDescription" : purposeDescription,
            "descriptionLegal" : descriptionLegal,
            "id" : id,
            "name" : name,
            "consent" : self.consent?.boolValue as Any ,
            "isPartOfASelectedStack" : isPartOfASelectedStack,
            "stackId" : stackId as Any,
            "showConsentToggle" : showConsentToggle,
        ]
    }
}

extension TCFStack {
    func toDictionary() -> NSDictionary {
        return[
            "description" : description,
            "id" : id,
            "name" : name,
            "purposeIds" : purposeIds,
            "specialFeatureIds" : specialFeatureIds,
        ]
    }
}

extension TCFVendor {
    func toDictionary() -> NSDictionary {
        return[
            "consent" : consent?.boolValue as Any ,
            "features" : features.map { $0.id },
            "flexiblePurposes" : flexiblePurposes.map { $0.id },
            "id" : id,
            "legitimateInterestConsent" : legitimateInterestConsent?.boolValue as Any ,
            "legitimateInterestPurposes" : legitimateInterestPurposes.map { $0.id },
            "name" : name,
            "policyUrl" : policyUrl,
            "purposes" : purposes.map { $0.id },
            "specialFeatures" : specialFeatures.map { $0.id },
            "specialPurposes" : specialPurposes.map { $0.id },
            "showConsentToggle" : showConsentToggle,
            "showLegitimateInterestToggle" : showLegitimateInterestToggle,
            "cookieMaxAgeSeconds" :  cookieMaxAgeSeconds as Any,
            "usesNonCookieAccess" : usesNonCookieAccess,
            "deviceStorageDisclosureUrl" : deviceStorageDisclosureUrl  as Any,
            "usesCookies" : usesCookies,
            "cookieRefresh" : cookieRefresh?.boolValue as Any,
            "dataSharedOutsideEU": dataSharedOutsideEU?.boolValue as Any
        ]
    }
}
