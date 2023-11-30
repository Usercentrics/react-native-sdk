package com.usercentrics.reactnativeusercentrics.extensions

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableMap
import com.usercentrics.sdk.UsercentricsCMPData
import com.usercentrics.sdk.v2.location.data.UsercentricsLocation
import com.usercentrics.sdk.v2.settings.data.CCPASettings
import com.usercentrics.sdk.v2.settings.data.CustomizationColor
import com.usercentrics.sdk.v2.settings.data.CustomizationFont
import com.usercentrics.sdk.v2.settings.data.FirstLayer
import com.usercentrics.sdk.v2.settings.data.PublishedApp
import com.usercentrics.sdk.v2.settings.data.SecondLayer
import com.usercentrics.sdk.v2.settings.data.TCF2ChangedPurposes
import com.usercentrics.sdk.v2.settings.data.TCF2Settings
import com.usercentrics.sdk.v2.settings.data.UsercentricsCategory
import com.usercentrics.sdk.v2.settings.data.UsercentricsCustomization
import com.usercentrics.sdk.v2.settings.data.UsercentricsLabels
import com.usercentrics.sdk.v2.settings.data.UsercentricsService
import com.usercentrics.sdk.v2.settings.data.UsercentricsSettings
import com.usercentrics.sdk.v2.settings.data.VariantsSettings

internal fun UsercentricsCMPData.serialize(): WritableMap {
    return Arguments.createMap().apply {
        putMap("settings", settings.serialize())
        putArray("services", services.map { it.serialize() }.serialize())
        putArray("categories", categories.map { it.serialize() }.serialize())
        putInt("activeVariant", activeVariant.ordinal)
        putMap("userLocation", userLocation.serialize())
    }
}

private fun UsercentricsSettings.serialize(): WritableMap {
    return mapOf(
        "labels" to labels.serialize(),
        "showInitialViewForVersionChange" to showInitialViewForVersionChange,
        "reshowBanner" to reshowBanner,
        "displayOnlyForEU" to displayOnlyForEU,
        "secondLayer" to secondLayer.serialize(),
        "cookiePolicyUrl" to cookiePolicyUrl,
        "tcf2" to tcf2?.serialize(),
        "ccpa" to ccpa?.serialize(),
        "privacyPolicyUrl" to privacyPolicyUrl,
        "firstLayer" to firstLayer?.serialize(),
        "imprintUrl" to imprintUrl,
        "firstLayerDescriptionHtml" to firstLayerDescriptionHtml,
        "bannerMobileDescriptionIsActive" to bannerMobileDescriptionIsActive,
        "firstLayerMobileDescriptionHtml" to firstLayerMobileDescriptionHtml,
        "version" to version,
        "language" to language,
        "tcf2Enabled" to tcf2Enabled,
        "settingsId" to settingsId,
        "languagesAvailable" to languagesAvailable,
        "enablePoweredBy" to enablePoweredBy,
        "editableLanguages" to editableLanguages,
        "customization" to customization?.serialize(),
        "variants" to variants?.serialize(),
        "dpsDisplayFormat" to dpsDisplayFormat?.ordinal,
        "framework" to framework?.ordinal,
        "publishedApps" to publishedApps?.map { it.serialize() },
    ).toWritableMap()
}

private fun UsercentricsLabels.serialize(): Map<String, Any?> {
    return mapOf(
        "btnAcceptAll" to btnAcceptAll,
        "btnDeny" to btnDeny,
        "btnSave" to btnSave,
        "firstLayerTitle" to firstLayerTitle,
        "accepted" to accepted,
        "denied" to denied,
        "date" to date,
        "decision" to decision,
        "dataCollectedList" to dataCollectedList,
        "dataCollectedInfo" to dataCollectedInfo,
        "locationOfProcessing" to locationOfProcessing,
        "transferToThirdCountries" to transferToThirdCountries,
        "dataPurposes" to dataPurposes,
        "dataPurposesInfo" to dataPurposesInfo,
        "dataRecipientsList" to dataRecipientsList,
        "descriptionOfService" to descriptionOfService,
        "history" to history,
        "historyDescription" to historyDescription,
        "legalBasisList" to legalBasisList,
        "legalBasisInfo" to legalBasisInfo,
        "processingCompanyTitle" to processingCompanyTitle,
        "retentionPeriod" to retentionPeriod,
        "technologiesUsed" to technologiesUsed,
        "technologiesUsedInfo" to technologiesUsedInfo,
        "cookiePolicyInfo" to cookiePolicyInfo,
        "optOut" to optOut,
        "policyOf" to policyOf,
        "imprintLinkText" to imprintLinkText,
        "privacyPolicyLinkText" to privacyPolicyLinkText,
        "categories" to categories,
        "anyDomain" to anyDomain,
        "day" to day,
        "days" to days,
        "domain" to domain,
        "duration" to duration,
        "informationLoadingNotPossible" to informationLoadingNotPossible,
        "hour" to hour,
        "hours" to hours,
        "identifier" to identifier,
        "maximumAgeCookieStorage" to maximumAgeCookieStorage,
        "minute" to minute,
        "minutes" to minutes,
        "month" to month,
        "months" to months,
        "multipleDomains" to multipleDomains,
        "no" to no,
        "nonCookieStorage" to nonCookieStorage,
        "seconds" to seconds,
        "session" to session,
        "loadingStorageInformation" to loadingStorageInformation,
        "storageInformation" to storageInformation,
        "detailedStorageInformation" to detailedStorageInformation,
        "tryAgain" to tryAgain,
        "type" to type,
        "year" to year,
        "years" to years,
        "yes" to yes,
        "storageInformationDescription" to storageInformationDescription,
        "btnBannerReadMore" to btnBannerReadMore,
        "linkToDpaInfo" to linkToDpaInfo,
        "second" to second,
        "consent" to consent,
        "secondLayerTitle" to secondLayerTitle,
        "secondLayerDescriptionHtml" to secondLayerDescriptionHtml,
        "btnMore" to btnMore,
        "explicit" to (explicit ?: ""),
        "transferToThirdCountriesInfo" to transferToThirdCountriesInfo,
        "more" to more,
        "headerModal" to headerModal,
        "furtherInformationOptOut" to furtherInformationOptOut,
        "cookiePolicyLinkText" to cookiePolicyLinkText,
        "noImplicit" to noImplicit,
        "yesImplicit" to yesImplicit,
    )
}

private fun CCPASettings.serialize(): WritableMap {
    return mapOf(
        "optOutNoticeLabel" to optOutNoticeLabel,
        "btnSave" to btnSave,
        "firstLayerTitle" to firstLayerTitle,
        "isActive" to isActive,
        "showOnPageLoad" to showOnPageLoad,
        "reshowAfterDays" to reshowAfterDays,
        "iabAgreementExists" to iabAgreementExists,
        "appFirstLayerDescription" to appFirstLayerDescription,
        "firstLayerMobileDescriptionIsActive" to firstLayerMobileDescriptionIsActive,
        "firstLayerMobileDescription" to firstLayerMobileDescription,
        "secondLayerTitle" to secondLayerTitle,
        "secondLayerDescription" to secondLayerDescription,
        "secondLayerHideLanguageSwitch" to secondLayerHideLanguageSwitch,
        "btnMoreInfo" to btnMoreInfo,
    ).toWritableMap()
}

private fun TCF2Settings.serialize(): WritableMap {
    return mapOf(
        "firstLayerTitle" to firstLayerTitle,
        "secondLayerTitle" to secondLayerTitle,
        "tabsPurposeLabel" to tabsPurposeLabel,
        "tabsVendorsLabel" to tabsVendorsLabel,
        "labelsFeatures" to labelsFeatures,
        "labelsIabVendors" to labelsIabVendors,
        "labelsNonIabPurposes" to labelsNonIabPurposes,
        "labelsNonIabVendors" to labelsNonIabVendors,
        "labelsPurposes" to labelsPurposes,
        "vendorFeatures" to vendorFeatures,
        "vendorLegitimateInterestPurposes" to vendorLegitimateInterestPurposes,
        "vendorPurpose" to vendorPurpose,
        "vendorSpecialFeatures" to vendorSpecialFeatures,
        "vendorSpecialPurposes" to vendorSpecialPurposes,
        "togglesConsentToggleLabel" to togglesConsentToggleLabel,
        "togglesLegIntToggleLabel" to togglesLegIntToggleLabel,
        "buttonsAcceptAllLabel" to buttonsAcceptAllLabel,
        "buttonsDenyAllLabel" to buttonsDenyAllLabel,
        "buttonsSaveLabel" to buttonsSaveLabel,
        "linksManageSettingsLabel" to linksManageSettingsLabel,
        "linksVendorListLinkLabel" to linksVendorListLinkLabel,
        "cmpId" to cmpId,
        "cmpVersion" to cmpVersion,
        "firstLayerHideToggles" to firstLayerHideToggles,
        "secondLayerHideToggles" to secondLayerHideToggles,
        "hideLegitimateInterestToggles" to hideLegitimateInterestToggles,
        "firstLayerHideButtonDeny" to firstLayerHideButtonDeny,
        "secondLayerHideButtonDeny" to secondLayerHideButtonDeny,
        "publisherCountryCode" to publisherCountryCode,
        "purposeOneTreatment" to purposeOneTreatment,
        "selectedVendorIds" to selectedVendorIds,
        "gdprApplies" to gdprApplies,
        "selectedStacks" to selectedStacks,
        "disabledSpecialFeatures" to disabledSpecialFeatures,
        "firstLayerShowDescriptions" to firstLayerShowDescriptions,
        "hideNonIabOnFirstLayer" to hideNonIabOnFirstLayer,
        "resurfacePeriodEnded" to resurfacePeriodEnded,
        "resurfacePurposeChanged" to resurfacePurposeChanged,
        "resurfaceVendorAdded" to resurfaceVendorAdded,
        "firstLayerDescription" to firstLayerDescription,
        "firstLayerAdditionalInfo" to firstLayerAdditionalInfo,
        "secondLayerDescription" to secondLayerDescription,
        "togglesSpecialFeaturesToggleOn" to togglesSpecialFeaturesToggleOn,
        "togglesSpecialFeaturesToggleOff" to togglesSpecialFeaturesToggleOff,
        "appLayerNoteResurface" to appLayerNoteResurface,
        "firstLayerNoteResurface" to firstLayerNoteResurface,
        "categoriesOfDataLabel" to categoriesOfDataLabel,
        "dataRetentionPeriodLabel" to dataRetentionPeriodLabel,
        "legitimateInterestLabel" to legitimateInterestLabel,
        "version" to version,
        "examplesLabel" to examplesLabel,
        "firstLayerMobileVariant" to firstLayerMobileVariant?.ordinal,
        "showDataSharedOutsideEUText" to showDataSharedOutsideEUText,
        "dataSharedOutsideEUText" to dataSharedOutsideEUText,
        "vendorIdsOutsideEUList" to vendorIdsOutsideEUList,
        "scope" to scope.ordinal,
        "changedPurposes" to changedPurposes?.serialize(),
    ).toWritableMap()
}

private fun UsercentricsCustomization.serialize(): WritableMap {
    return mapOf(
        "color" to color?.serialize(),
        "font" to font?.serialize(),
        "logoUrl" to logoUrl,
        "borderRadiusLayer" to borderRadiusLayer,
        "borderRadiusButton" to borderRadiusButton,
        "overlayOpacity" to overlayOpacity,
    ).toWritableMap()
}

private fun CustomizationFont.serialize(): WritableMap {
    return mapOf(
        "family" to family,
        "size" to size,
    ).toWritableMap()
}

private fun CustomizationColor.serialize(): WritableMap {
    return mapOf(
        "primary" to primary,
        "acceptBtnText" to acceptBtnText,
        "acceptBtnBackground" to acceptBtnBackground,
        "denyBtnText" to denyBtnText,
        "denyBtnBackground" to denyBtnBackground,
        "saveBtnText" to saveBtnText,
        "saveBtnBackground" to saveBtnBackground,
        "linkIcon" to linkIcon,
        "linkFont" to linkFont,
        "text" to text,
        "layerBackground" to layerBackground,
        "overlay" to overlay,
        "toggleInactiveBackground" to toggleInactiveBackground,
        "toggleInactiveIcon" to toggleInactiveIcon,
        "toggleActiveBackground" to toggleActiveBackground,
        "toggleActiveIcon" to toggleActiveIcon,
        "toggleDisabledBackground" to toggleDisabledBackground,
        "toggleDisabledIcon" to toggleDisabledIcon,
        "secondLayerTab" to secondLayerTab,
        "moreBtnBackground" to moreBtnBackground,
        "moreBtnText" to moreBtnText,
    ).toWritableMap()
}

private fun FirstLayer.serialize(): WritableMap {
    return mapOf(
        "hideButtonDeny" to hideButtonDeny,
    ).toWritableMap()
}

private fun SecondLayer.serialize(): WritableMap {
    return mapOf(
        "tabsCategoriesLabel" to tabsCategoriesLabel,
        "tabsServicesLabel" to tabsServicesLabel,
        "acceptButtonText" to (acceptButtonText ?: ""),
        "denyButtonText" to (denyButtonText ?: ""),
        "hideButtonDeny" to hideButtonDeny,
        "hideLanguageSwitch" to hideLanguageSwitch,
        "hideTogglesForServices" to hideTogglesForServices,
        "hideDataProcessingServices" to hideDataProcessingServices,
    ).toWritableMap()
}

private fun UsercentricsService.serialize(): WritableMap {
    return mapOf(
        "templateId" to templateId,
        "version" to version,
        "type" to type,
        "isEssential" to isEssential,
        "dataProcessor" to dataProcessor,
        "dataPurposes" to dataPurposes,
        "processingCompany" to processingCompany,
        "nameOfProcessingCompany" to nameOfProcessingCompany,
        "addressOfProcessingCompany" to addressOfProcessingCompany,
        "descriptionOfService" to descriptionOfService,
        "languagesAvailable" to languagesAvailable,
        "dataCollectedList" to dataCollectedList,
        "dataPurposesList" to dataPurposesList,
        "dataRecipientsList" to dataRecipientsList,
        "legalBasisList" to legalBasisList,
        "retentionPeriodList" to retentionPeriodList,
        "subConsents" to subConsents,
        "language" to language,
        "linkToDpa" to linkToDpa,
        "legalGround" to legalGround,
        "optOutUrl" to optOutUrl,
        "policyOfProcessorUrl" to policyOfProcessorUrl,
        "categorySlug" to categorySlug,
        "retentionPeriodDescription" to retentionPeriodDescription,
        "dataProtectionOfficer" to dataProtectionOfficer,
        "privacyPolicyURL" to privacyPolicyURL,
        "cookiePolicyURL" to cookiePolicyURL,
        "locationOfProcessing" to locationOfProcessing,
        "dataCollectedDescription" to dataCollectedDescription,
        "thirdCountryTransfer" to thirdCountryTransfer,
        "description" to description,
        "cookieMaxAgeSeconds" to cookieMaxAgeSeconds,
        "usesNonCookieAccess" to usesNonCookieAccess,
        "deviceStorageDisclosureUrl" to deviceStorageDisclosureUrl,
        "isDeactivated" to isDeactivated,
        "disableLegalBasis" to disableLegalBasis,
        "technologyUsed" to technologyUsed,
        "deviceStorage" to deviceStorage.serialize(),
        "isHidden" to isHidden,
    ).toWritableMap()
}

private fun UsercentricsCategory.serialize(): WritableMap {
    return mapOf(
        "categorySlug" to categorySlug,
        "label" to label,
        "description" to description,
        "isEssential" to isEssential
    ).toWritableMap()
}

private fun UsercentricsLocation.serialize(): WritableMap {
    return mapOf(
        "countryCode" to countryCode,
        "regionCode" to regionCode,
        "isInEU" to isInEU(),
        "isInUS" to isInUS(),
        "isInCalifornia" to isInCalifornia(),
    ).toWritableMap()
}

private fun VariantsSettings?.serialize(): Any? {
    if (this == null) {
        return null
    }
    return mapOf(
        "enabled" to enabled,
        "experimentsJson" to experimentsJson,
        "activateWith" to activateWith,
    )
}

private fun PublishedApp.serialize(): Any {
    return mapOf(
        "bundleId" to bundleId,
        "platform" to platform.ordinal,
    )
}

private fun TCF2ChangedPurposes?.serialize(): Any? {
    if (this == null) {
        return null
    }
    return mapOf(
        "purposes" to purposes,
        "legIntPurposes" to legIntPurposes
    )
}
