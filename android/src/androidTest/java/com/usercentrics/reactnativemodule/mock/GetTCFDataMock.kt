package com.usercentrics.reactnativemodule.mock

import com.usercentrics.sdk.services.tcf.interfaces.IdAndName
import com.usercentrics.sdk.services.tcf.interfaces.TCFData
import com.usercentrics.sdk.services.tcf.interfaces.TCFFeature
import com.usercentrics.sdk.services.tcf.interfaces.TCFPurpose
import com.usercentrics.sdk.services.tcf.interfaces.TCFSpecialFeature
import com.usercentrics.sdk.services.tcf.interfaces.TCFSpecialPurpose
import com.usercentrics.sdk.services.tcf.interfaces.TCFStack
import com.usercentrics.sdk.services.tcf.interfaces.TCFVendor
import com.usercentrics.tcf.core.model.gvl.VendorUrl

internal class GetTCFDataMock {
    companion object {
        val fake = TCFData(
            features = listOf(
                TCFFeature(
                    purposeDescription = "Data from offline data sources can be combined with your online activity in support of one or more purposes",
                    illustrations = listOf("Vendors can:\n* Combine data obtained offline with data collected online in support of one or more Purposes or Special Purposes."),
                    id = 2,
                    name = "Link different devices",
                )
            ),
            purposes = listOf(
                TCFPurpose(
                    purposeDescription = "Cookies, device identifiers, or other information can be stored or accessed on your device for the purposes presented to you.",
                    illustrations = listOf("Vendors can:\n* Store and access information on the device such as cookies and device identifiers presented to a user."),
                    id = 1,
                    name = "Store and/or access information on a device",
                    consent = null,
                    isPartOfASelectedStack = true,
                    legitimateInterestConsent = null,
                    showConsentToggle = false,
                    showLegitimateInterestToggle = false,
                    stackId = null,
                )
            ),
            specialFeatures = listOf(
                TCFSpecialFeature(
                    purposeDescription = "Your precise geolocation data can be used in support of one or more purposes. This means your location can be accurate to within several meters.",
                    illustrations = listOf("Vendors can:\n* Collect and process precise geolocation data in support of one or more purposes.\nN.B. Precise geolocation means that there are no restrictions on the precision of a user’s location; this can be accurate to within several meters."),
                    id = 1,
                    name = "Use precise geolocation data",
                    consent = null,
                    isPartOfASelectedStack = false,
                    stackId = null,
                    showConsentToggle = false,
                )
            ),
            specialPurposes = listOf(
                TCFSpecialPurpose(
                    purposeDescription = "Your data can be used to monitor for and prevent fraudulent activity, and ensure systems and processes work properly and securely.",
                    illustrations = listOf("To ensure security, prevent fraud and debug vendors can:\n* Ensure data are securely transmitted\n* Detect and prevent malicious, fraudulent, invalid, or illegal activity.\n* Ensure correct and efficient operation of systems and processes, including to monitor and enhance the performance of systems and processes engaged in permitted purposes\nVendors cannot:\n* Conduct any other data processing operation allowed under a different purpose under this purpose.\nNote: Data collected and used to ensure security, prevent fraud, and debug may include automatically-sent device characteristics for identification, precise geolocation data, and data obtained by actively scanning device characteristics for identification without separate disclosure and/or opt-in."),
                    id = 1,
                    name = "Ensure security, prevent fraud, and debug",
                )
            ),
            stacks = listOf(
                TCFStack(
                    description = "Ads can be personalised based on a profile. More data can be added to better personalise ads.",

                    id = 3,
                    name = "Personalised ads",

                    purposeIds = listOf(
                        2,
                        3,
                        4
                    ),
                    specialFeatureIds = listOf(),
                )
            ),
            vendors = listOf(
                TCFVendor(
                    consent = null,
                    features = listOf(IdAndName(3, "")),
                    flexiblePurposes = listOf(),
                    id = 7,
                    legitimateInterestConsent = null,
                    legitimateInterestPurposes = listOf(),
                    name = "Vibrant Media Limited",
                    policyUrl = "https://www.vibrantmedia.com/en/privacy-policy/",
                    purposes = listOf(
                        IdAndName(1, ""),
                        IdAndName(3, ""),
                        IdAndName(4, ""),
                        IdAndName(5, ""),
                        IdAndName(6, ""),
                        IdAndName(7, ""),
                        IdAndName(8, "")
                    ),
                    restrictions = listOf(),
                    specialFeatures = listOf(IdAndName(1, "")),
                    specialPurposes = listOf(),
                    showConsentToggle = true,
                    showLegitimateInterestToggle = true,
                    cookieMaxAgeSeconds = null,
                    usesNonCookieAccess = false,
                    deviceStorageDisclosureUrl = null,
                    deviceStorage = null,
                    usesCookies = false,
                    cookieRefresh = null,
                    dataSharedOutsideEU = false,
                    dataRetention = null,
                    dataCategories = listOf(IdAndName(id = 123, name = "name")),
                    vendorUrls = listOf(VendorUrl(langId = "langId", privacy = "privacy", legIntClaim = "legIntClaim"))
                )
            ),
            tcString = "abc",
            thirdPartyCount = 123,
        )

        // From the debugger
        val expected = mapOf(
            "features" to listOf(
                mapOf(
                    "purposeDescription" to "Data from offline data sources can be combined with your online activity in support of one or more purposes",
                    "illustrations" to listOf("Vendors can:\n* Combine data obtained offline with data collected online in support of one or more Purposes or Special Purposes."),
                    "id" to 2,
                    "name" to "Link different devices",
                )
            ),
            "purposes" to listOf(
                mapOf(
                    "purposeDescription" to "Cookies, device identifiers, or other information can be stored or accessed on your device for the purposes presented to you.",
                    "illustrations" to listOf("Vendors can:\n* Store and access information on the device such as cookies and device identifiers presented to a user."),
                    "id" to 1,
                    "name" to "Store and/or access information on a device",
                    "consent" to null,
                    "isPartOfASelectedStack" to true,
                    "legitimateInterestConsent" to null,
                    "showConsentToggle" to false,
                    "showLegitimateInterestToggle" to false,
                    "stackId" to null,
                )
            ),
            "specialFeatures" to listOf(
                mapOf(
                    "purposeDescription" to "Your precise geolocation data can be used in support of one or more purposes. This means your location can be accurate to within several meters.",
                    "illustrations" to listOf("Vendors can:\n* Collect and process precise geolocation data in support of one or more purposes.\nN.B. Precise geolocation means that there are no restrictions on the precision of a user’s location; this can be accurate to within several meters."),
                    "id" to 1,
                    "name" to "Use precise geolocation data",
                    "consent" to null,
                    "isPartOfASelectedStack" to false,
                    "stackId" to null,
                    "showConsentToggle" to false,
                )
            ),
            "specialPurposes" to listOf(
                mapOf(
                    "purposeDescription" to "Your data can be used to monitor for and prevent fraudulent activity, and ensure systems and processes work properly and securely.",
                    "illustrations" to listOf("To ensure security, prevent fraud and debug vendors can:\n* Ensure data are securely transmitted\n* Detect and prevent malicious, fraudulent, invalid, or illegal activity.\n* Ensure correct and efficient operation of systems and processes, including to monitor and enhance the performance of systems and processes engaged in permitted purposes\nVendors cannot:\n* Conduct any other data processing operation allowed under a different purpose under this purpose.\nNote: Data collected and used to ensure security, prevent fraud, and debug may include automatically-sent device characteristics for identification, precise geolocation data, and data obtained by actively scanning device characteristics for identification without separate disclosure and/or opt-in."),
                    "id" to 1,
                    "name" to "Ensure security, prevent fraud, and debug",
                )
            ),
            "stacks" to listOf(
                mapOf(
                    "description" to "Ads can be personalised based on a profile. More data can be added to better personalise ads.",
                    "id" to 3,
                    "name" to "Personalised ads",

                    "purposeIds" to listOf(
                        2,
                        3,
                        4
                    ),
                    "specialFeatureIds" to listOf<Any>(),
                )
            ),
            "vendors" to listOf(
                mapOf(
                    "consent" to null,
                    "features" to listOf(3),
                    "flexiblePurposes" to listOf<Any>(),
                    "id" to 7,
                    "legitimateInterestConsent" to null,
                    "legitimateInterestPurposes" to listOf<Any>(),
                    "name" to "Vibrant Media Limited",
                    "policyUrl" to "https://www.vibrantmedia.com/en/privacy-policy/",
                    "purposes" to listOf(
                        1,
                        3,
                        4,
                        5,
                        6,
                        7,
                        8
                    ),
                    "specialFeatures" to listOf(1),
                    "specialPurposes" to listOf<Any>(),
                    "showConsentToggle" to true,
                    "showLegitimateInterestToggle" to true,
                    "cookieMaxAgeSeconds" to null,
                    "usesNonCookieAccess" to false,
                    "deviceStorageDisclosureUrl" to null,
                    "usesCookies" to false,
                    "cookieRefresh" to null,
                    "dataSharedOutsideEU" to false,
                    "dataRetention" to null,
                    "dataCategories" to listOf(123),
                    "vendorUrls" to listOf(mapOf("langId" to "langId", "privacy" to "privacy", "legIntClaim" to "legIntClaim")),
                ),
            ),
            "tcString" to "abc",
            "thirdPartyCount" to 123,
        )
    }
}
