import Foundation
import Usercentrics

extension UsercentricsCMPData {
    func toDictionary() -> NSDictionary {
        return [
            "settings": self.settings.toDictionary(),
            "services": self.services.map { $0.toDictionary() },
            "categories": self.categories.map { $0.toDictionary() },
            "activeVariant": self.activeVariant.ordinal as Any,
            "userLocation": self.userLocation.toDictionary(),
            "legalBasis": self.legalBasis.toDictionary()
        ]
    }
}

extension UsercentricsSettings {
    func toDictionary() -> NSDictionary {
        return [
            "labels" : self.labels.toDictionary(),
            "showInitialViewForVersionChange": self.showInitialViewForVersionChange,
            "reshowBanner": self.reshowBanner as Any,
            "displayOnlyForEU" : self.displayOnlyForEU,
            "secondLayer" : self.secondLayer.toDictionary() as Any,
            "cookiePolicyUrl": self.cookiePolicyUrl as Any,
            "tcf2": self.tcf2?.toDictionary() as Any,
            "ccpa": self.ccpa?.toDictionary() as Any,
            "privacyPolicyUrl": self.privacyPolicyUrl as Any,
            "firstLayer": self.firstLayer?.toDictionary() as Any,
            "imprintUrl": self.imprintUrl as Any,
            "firstLayerDescriptionHtml": self.firstLayerDescriptionHtml as Any,
            "bannerMobileDescriptionIsActive": self.bannerMobileDescriptionIsActive,
            "firstLayerMobileDescriptionHtml": self.firstLayerMobileDescriptionHtml as Any,
            "version": self.version,
            "language" : self.language,
            "tcf2Enabled" : self.tcf2Enabled,
            "settingsId" : self.settingsId,
            "languagesAvailable" : self.languagesAvailable,
            "enablePoweredBy" : self.enablePoweredBy,
            "editableLanguages" : self.editableLanguages,
            "customization" : self.customization?.toDictionary() as Any,
            "variants": (self.variants?.toDictionary() ?? nil) as Any,
            "dpsDisplayFormat": (self.dpsDisplayFormat?.ordinal ?? nil) as Any,
            "framework": (self.framework?.ordinal ?? nil) as Any,
            "publishedApps": (self.publishedApps?.map { $0.toDictionary() } ?? nil) as Any,
            "renewConsentsTimestamp": self.renewConsentsTimestamp as Any,
            "consentWebhook": self.consentWebhook as Any,
        ]
    }
}

extension UsercentricsLabels {    
    func toDictionary() -> NSDictionary {
        return [
            "btnAcceptAll" : self.btnAcceptAll,
            "btnDeny" : self.btnDeny,
            "btnSave" : self.btnSave,
            "firstLayerTitle" : self.firstLayerTitle,
            "accepted" : self.accepted,
            "denied" : self.denied,
            "date" : self.date,
            "decision" : self.decision,
            "dataCollectedList" : self.dataCollectedList,
            "dataCollectedInfo" : self.dataCollectedInfo,
            "locationOfProcessing" : self.locationOfProcessing,
            "transferToThirdCountries" : self.transferToThirdCountries,
            "transferToThirdCountriesInfo": self.transferToThirdCountriesInfo,
            "dataPurposes" : self.dataPurposes,
            "dataPurposesInfo" : self.dataPurposesInfo,
            "dataRecipientsList" : self.dataRecipientsList,
            "descriptionOfService" : self.descriptionOfService,
            "history" : self.history,
            "historyDescription" : self.historyDescription,
            "legalBasisList" : self.legalBasisList,
            "legalBasisInfo" : self.legalBasisInfo,
            "processingCompanyTitle" : self.processingCompanyTitle,
            "retentionPeriod" : self.retentionPeriod,
            "technologiesUsed" : self.technologiesUsed,
            "technologiesUsedInfo" : self.technologiesUsedInfo,
            "cookiePolicyInfo" : self.cookiePolicyInfo,
            "optOut" : self.optOut,
            "policyOf" : self.policyOf,
            "imprintLinkText" : self.imprintLinkText,
            "privacyPolicyLinkText" : self.privacyPolicyLinkText,
            "categories" : self.categories,
            "anyDomain" : self.anyDomain,
            "day" : self.day,
            "days" : self.days,
            "domain" : self.domain,
            "duration" : self.duration,
            "informationLoadingNotPossible" : self.informationLoadingNotPossible,
            "hour" : self.hour,
            "hours" : self.hours,
            "identifier" : self.identifier,
            "maximumAgeCookieStorage" : self.maximumAgeCookieStorage,
            "minute" : self.minute,
            "minutes" : self.minutes,
            "month" : self.month,
            "months" : self.months,
            "multipleDomains" : self.multipleDomains,
            "no" : self.no,
            "nonCookieStorage" : self.nonCookieStorage,
            "seconds" : self.seconds,
            "session" : self.session,
            "loadingStorageInformation" : self.loadingStorageInformation,
            "storageInformation" : self.storageInformation,
            "detailedStorageInformation" : self.detailedStorageInformation,
            "tryAgain" : self.tryAgain,
            "type" : self.type,
            "year" : self.year,
            "years" : self.years,
            "yes" : self.yes,
            "storageInformationDescription" : self.storageInformationDescription,
            "btnBannerReadMore" : self.btnBannerReadMore,
            "readLess": self.readLess,
            "btnMore": self.btnMore,
            "more": self.more,
            "linkToDpaInfo" : self.linkToDpaInfo,
            "second" : self.second,
            "consent" : self.consent,
            "headerModal": self.headerModal,
            "secondLayerDescriptionHtml" : self.secondLayerDescriptionHtml,
            "secondLayerTitle" : self.secondLayerTitle ?? "",
            
            // Optional
            "settings" : self.settings ?? "",
            "subConsents" : self.subConsents ?? "",
            "btnAccept" : self.btnAccept ?? "",
            "poweredBy" : self.poweredBy ?? "",
            "dataProtectionOfficer" : self.dataProtectionOfficer ?? "",
            "nameOfProcessingCompany" : self.nameOfProcessingCompany ?? "",
            "btnBack" : self.btnBack ?? "",
            "copy" : self.copyLabel ?? "",
            "copied" : self.copied ?? "",
            "basic" : self.basic ?? "",
            "advanced" : self.advanced ?? "",
            "processingCompany" : self.processingCompany ?? "",
            "name" : self.name ?? "",
            "explicit": self.explicit_ ?? "",
            "implicit": self.implicit ?? "",
            "btnMoreInfo" : self.btnMoreInfo ?? "",
            "furtherInformationOptOut": self.furtherInformationOptOut,
            "cookiePolicyLinkText": self.cookiePolicyLinkText,
            "noImplicit": self.noImplicit,
            "yesImplicit": self.yesImplicit,
        ]
    }
}

extension CCPASettings {
    func toDictionary() -> NSDictionary {
        return [
            "optOutNoticeLabel" : self.optOutNoticeLabel,
            "btnSave" : self.btnSave,
            "firstLayerTitle" : self.firstLayerTitle,
            "isActive" : self.isActive,
            "showOnPageLoad" : self.showOnPageLoad,
            "reshowAfterDays" : self.reshowAfterDays,
            "iabAgreementExists" : self.iabAgreementExists,
            "appFirstLayerDescription" : self.appFirstLayerDescription as Any,
            "firstLayerMobileDescriptionIsActive" : self.firstLayerMobileDescriptionIsActive,
            "firstLayerMobileDescription" : self.firstLayerMobileDescription as Any,
            "secondLayerTitle" : self.secondLayerTitle as Any,
            "secondLayerDescription" : self.secondLayerDescription as Any,
            "secondLayerHideLanguageSwitch" : self.secondLayerHideLanguageSwitch,
            "btnMoreInfo" : self.btnMoreInfo as Any,
        ]
    }
}


extension TCF2Settings {
    func toDictionary() -> NSDictionary {
        return [
            "firstLayerTitle" : self.firstLayerTitle,
            "secondLayerTitle" : self.secondLayerTitle,
            "tabsPurposeLabel" : self.tabsPurposeLabel,
            "tabsVendorsLabel" : self.tabsVendorsLabel,
            "labelsFeatures" : self.labelsFeatures,
            "labelsIabVendors" : self.labelsIabVendors,
            "labelsNonIabPurposes" : self.labelsNonIabPurposes,
            "labelsNonIabVendors" : self.labelsNonIabVendors,
            "labelsPurposes" : self.labelsPurposes,
            "vendorFeatures" : self.vendorFeatures,
            "vendorLegitimateInterestPurposes" : self.vendorLegitimateInterestPurposes,
            "vendorPurpose" : self.vendorPurpose,
            "vendorSpecialFeatures" : self.vendorSpecialFeatures,
            "vendorSpecialPurposes" : self.vendorSpecialPurposes,
            "togglesConsentToggleLabel" : self.togglesConsentToggleLabel,
            "togglesLegIntToggleLabel" : self.togglesLegIntToggleLabel,
            "buttonsAcceptAllLabel" : self.buttonsAcceptAllLabel,
            "buttonsDenyAllLabel" : self.buttonsDenyAllLabel,
            "buttonsSaveLabel" : self.buttonsSaveLabel,
            "linksManageSettingsLabel" : self.linksManageSettingsLabel,
            "linksVendorListLinkLabel" : self.linksVendorListLinkLabel,
            "cmpId" : self.cmpId,
            "cmpVersion" : self.cmpVersion,
            "firstLayerHideToggles" : self.firstLayerHideToggles,
            "secondLayerHideToggles" : self.secondLayerHideToggles,
            "hideLegitimateInterestToggles" : self.hideLegitimateInterestToggles,
            "firstLayerHideButtonDeny" : self.firstLayerHideButtonDeny?.boolValue as Any,
            "secondLayerHideButtonDeny" : self.secondLayerHideButtonDeny,
            "publisherCountryCode" : self.publisherCountryCode,
            "purposeOneTreatment" : self.purposeOneTreatment,
            "selectedVendorIds" : self.selectedVendorIds,
            "gdprApplies" : self.gdprApplies,
            "selectedStacks" : self.selectedStacks,
            "disabledSpecialFeatures" : self.disabledSpecialFeatures,
            "firstLayerShowDescriptions" : self.firstLayerShowDescriptions,
            "hideNonIabOnFirstLayer" : self.hideNonIabOnFirstLayer,
            "resurfacePeriodEnded" : self.resurfacePeriodEnded,
            "resurfacePurposeChanged" : self.resurfacePurposeChanged,
            "resurfaceVendorAdded" : self.resurfaceVendorAdded,
            "firstLayerDescription" : self.firstLayerDescription as Any,
            "firstLayerAdditionalInfo" : self.firstLayerAdditionalInfo as Any,
            "secondLayerDescription" : self.secondLayerDescription as Any,
            "togglesSpecialFeaturesToggleOn" : self.togglesSpecialFeaturesToggleOn as Any,
            "togglesSpecialFeaturesToggleOff" : self.togglesSpecialFeaturesToggleOff as Any,
            "appLayerNoteResurface" : self.appLayerNoteResurface as Any,
            "firstLayerNoteResurface" : self.firstLayerNoteResurface as Any,
            "version": self.version as Any,
            "categoriesOfDataLabel": self.categoriesOfDataLabel,
            "dataRetentionPeriodLabel": self.dataRetentionPeriodLabel,
            "legitimateInterestLabel": self.legitimateInterestLabel,
            "version": self.version,
            "examplesLabel": self.examplesLabel,
            "firstLayerMobileVariant": (self.firstLayerMobileVariant?.ordinal ?? nil) as Any,
            "showDataSharedOutsideEUText": self.showDataSharedOutsideEUText,
            "dataSharedOutsideEUText": self.dataSharedOutsideEUText as Any,
            "vendorIdsOutsideEUList": self.vendorIdsOutsideEUList,
            "scope": self.scope.ordinal,
            "changedPurposes": self.changedPurposes?.toDictionary() as Any,
            "acmV2Enabled": self.acmV2Enabled,
            "selectedATPIds": self.selectedATPIds
        ]
    }
}


extension UsercentricsCustomization {
    func toDictionary() -> NSDictionary {
        return [
            "color" : self.color?.toDictionary() as Any,
            "font" : self.font?.toDictionary() as Any,
            "logoUrl" : self.logoUrl as Any,
            "borderRadiusLayer" : self.borderRadiusLayer as Any,
            "borderRadiusButton" : self.borderRadiusButton as Any,
            "overlayOpacity" : self.overlayOpacity as Any,
        ]
    }
}



extension CustomizationFont {
    func toDictionary() -> NSDictionary {
        return [
            "family" : self.family as Any,
            "size" : self.size as Any,
        ]
    }
}



extension CustomizationColor {
    func toDictionary() -> NSDictionary {
        return [
            "primary" : self.primary as Any,
            "acceptBtnText" : self.acceptBtnText as Any,
            "acceptBtnBackground" : self.acceptBtnBackground as Any,
            "denyBtnText" : self.denyBtnText as Any,
            "denyBtnBackground" : self.denyBtnBackground as Any,
            "saveBtnText" : self.saveBtnText as Any,
            "saveBtnBackground" : self.saveBtnBackground as Any,
            "linkIcon" : self.linkIcon as Any,
            "linkFont" : self.linkFont as Any,
            "text" : self.text as Any,
            "layerBackground" : self.layerBackground as Any,
            "overlay" : self.overlay as Any,
            "toggleInactiveBackground" : self.toggleInactiveBackground as Any,
            "toggleInactiveIcon" : self.toggleInactiveIcon as Any,
            "toggleActiveBackground" : self.toggleActiveBackground as Any,
            "toggleActiveIcon" : self.toggleActiveIcon as Any,
            "toggleDisabledBackground" : self.toggleDisabledBackground as Any,
            "toggleDisabledIcon" : self.toggleDisabledIcon as Any,
            "secondLayerTab" : self.secondLayerTab as Any,
        ]
    }
}



extension FirstLayer {
    func toDictionary() -> NSDictionary {
        return [
            "hideButtonDeny" : hideButtonDeny?.boolValue as Any,
        ]
    }
}


extension SecondLayer {
    func toDictionary() -> NSDictionary {
        return [
            "tabsCategoriesLabel" : self.tabsCategoriesLabel,
            "tabsServicesLabel" : self.tabsServicesLabel,
            "hideButtonDeny" : hideButtonDeny?.boolValue as Any,
            "hideLanguageSwitch" : hideLanguageSwitch?.boolValue as Any,
            "acceptButtonText": self.acceptButtonText ?? "",
            "denyButtonText": self.denyButtonText ?? "",
            "hideTogglesForServices": self.hideTogglesForServices,
            "hideDataProcessingServices": self.hideDataProcessingServices,
        ]
    }
}


extension UsercentricsService {
    func toDictionary() -> NSDictionary {
        return [
            "templateId" : self.templateId as Any,
            "version" : self.version as Any,
            "type" : self.type as Any,
            "isEssential": self.isEssential,
            "dataProcessor" : self.dataProcessor as Any,
            "dataPurposes" : self.dataPurposes,
            "processingCompany" : self.processingCompany as Any,
            "nameOfProcessingCompany" : self.nameOfProcessingCompany,
            "addressOfProcessingCompany" : self.addressOfProcessingCompany,
            "descriptionOfService" : self.descriptionOfService,
            "languagesAvailable" : self.languagesAvailable,
            "dataCollectedList" : self.dataCollectedList,
            "dataPurposesList" : self.dataPurposesList,
            "dataRecipientsList" : self.dataRecipientsList,
            "legalBasisList" : self.legalBasisList,
            "retentionPeriodList" : self.retentionPeriodList,
            "subConsents" : self.subConsents as Any,
            "language" : self.language,
            "linkToDpa" : self.linkToDpa,
            "legalGround" : self.legalGround,
            "optOutUrl" : self.optOutUrl,
            "policyOfProcessorUrl" : self.policyOfProcessorUrl,
            "categorySlug" : self.categorySlug as Any,
            "retentionPeriodDescription" : self.retentionPeriodDescription,
            "dataProtectionOfficer" : self.dataProtectionOfficer,
            "privacyPolicyURL" : self.privacyPolicyURL,
            "cookiePolicyURL" : self.cookiePolicyURL,
            "locationOfProcessing" : self.locationOfProcessing,
            "dataCollectedDescription" : self.dataCollectedDescription as Any,
            "thirdCountryTransfer" : self.thirdCountryTransfer,
            "description" : self.description_ as Any,
            "cookieMaxAgeSeconds" : self.cookieMaxAgeSeconds as Any,
            "usesNonCookieAccess" : usesNonCookieAccess?.boolValue as Any,
            "deviceStorageDisclosureUrl" : self.deviceStorageDisclosureUrl as Any,
            "isDeactivated" : isDeactivated?.boolValue as Any,
            "disableLegalBasis" : disableLegalBasis?.boolValue as Any,
            "technologyUsed": self.technologyUsed,
            "deviceStorage": self.deviceStorage.toDictionary(),
            "isHidden": self.isHidden
        ]
    }
}

extension ConsentDisclosureObject {
    func toDictionary() -> Any {
        return self.disclosures.map { $0.toDictionary() }
    }
}

extension ConsentDisclosure {
    func toDictionary() -> Any {
        return [
            "identifier": self.identifier as Any,
            "type": self.type?.ordinal ?? "",
            "name": self.name as Any,
            "maxAgeSeconds": self.maxAgeSeconds as Any,
            "cookieRefresh": self.cookieRefresh,
            "purposes": self.purposes,
            "domain": self.domain ?? "",
            "description": self.description_ as Any,
        ]
    }
}


extension UsercentricsCategory {
    func toDictionary() -> NSDictionary? {
        return [
            "categorySlug" : self.categorySlug,
            "label" : self.label as Any,
            "description" : self.description_ as Any,
            "isEssential" : self.isEssential
        ]
    }
}

extension UsercentricsLocation {
    func toDictionary() -> NSDictionary {
        return [
            "countryCode" : self.countryCode,
            "regionCode" : self.regionCode,
            "isInEU" : self.isInEU(),
            "isInUS" : self.isInUS(),
            "isInCalifornia" : self.isInCalifornia(),
        ]
    }
}


extension LegalBasisLocalization {

    func toDictionary() -> NSDictionary {
        return [
            "labelsAria": (labelsAria?.toDictionary() ?? nil) as Any,
            "data": data as Any
        ]
    }
}

extension TranslationAriaLabels {
    
    func toDictionary() -> NSDictionary {
        return [
            "acceptAllButton": acceptAllButton as Any,
            "ccpaButton": ccpaButton as Any,
            "ccpaMoreInformation": ccpaMoreInformation as Any,
            "closeButton": closeButton as Any,
            "collapse": collapse as Any,
            "cookiePolicyButton": cookiePolicyButton as Any,
            "copyControllerId": copyControllerId as Any,
            "denyAllButton": denyAllButton as Any,
            "expand": expand as Any,
            "fullscreenButton": fullscreenButton as Any,
            "imprintButton": imprintButton as Any,
            "languageSelector": languageSelector as Any,
            "privacyButton": privacyButton as Any,
            "privacyPolicyButton": privacyPolicyButton as Any,
            "saveButton": saveButton as Any,
            "serviceInCategoryDetails": serviceInCategoryDetails as Any,
            "servicesInCategory": servicesInCategory as Any,
            "tabButton": tabButton as Any,
            "usercentricsCMPButtons": usercentricsCMPButtons as Any,
            "usercentricsCMPContent": usercentricsCMPContent as Any,
            "usercentricsCMPHeader": usercentricsCMPHeader as Any,
            "usercentricsCMPUI": usercentricsCMPUI as Any,
            "usercentricsCard": usercentricsCard as Any,
            "usercentricsList": usercentricsList as Any,
            "vendorConsentToggle": vendorConsentToggle as Any,
            "vendorDetailedStorageInformation": vendorDetailedStorageInformation as Any,
            "vendorLegIntToggle": vendorLegIntToggle as Any
        ]
    }
}

extension VariantsSettings {
    func toDictionary() -> Any {
        return [
            "enabled": enabled,
            "experimentsJson": experimentsJson,
            "activateWith": activateWith,
        ] as [String : Any]
    }
}

extension PublishedApp {
    func toDictionary() -> Any {
        return [
            "bundleId": bundleId,
            "platform": platform.ordinal,
        ]
    }
}

extension TCF2ChangedPurposes {
    func toDictionary() -> Any {
        return [
            "purposes": purposes,
            "legIntPurposes": legIntPurposes
        ]
    }
}

extension AdditionalConsentModeData {

    func toDictionary() -> NSDictionary {
        return [
            "acString": self.acString,
            "adTechProviders": self.adTechProviders.map { $0.toDictionary() }
        ]
    }
}

extension AdTechProvider {

    func toDictionary() -> NSDictionary {
        return [
            "id" : self.id,
            "name" : self.name,
            "privacyPolicyUrl" : self.privacyPolicyUrl,
            "consent" : self.consent
        ]
    }
}
