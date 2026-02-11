import Usercentrics

extension UsercentricsCMPData {

  static func mock() -> UsercentricsCMPData {
    return .init(settings: .mock(),
                 services: [.mock()],
                 legalBasis: .mock(),
                 activeVariant: .tcf,
                 userLocation: .mock())
  }
}

extension UsercentricsSettings {

  static func mock() -> UsercentricsSettings {
    return .init(labels: .mock(),
                 secondLayer: .mock(),
                 version: "1.0.0",
                 language: "en",
                 imprintUrl: "imprintUrl",
                 privacyPolicyUrl: "privacyPolicyUrl",
                 cookiePolicyUrl: "cookiePolicyUrl",
                 firstLayerDescriptionHtml: "firstLayerDescriptionHtml",
                 firstLayerMobileDescriptionHtml: "firstLayerMobileDescriptionHtml",
                 settingsId: "settingsId",
                 bannerMobileDescriptionIsActive: true,
                 enablePoweredBy: true,
                 displayOnlyForEU: true,
                 tcf2Enabled: true,
                 reshowBanner: 123,
                 editableLanguages: ["editableLanguages"],
                 languagesAvailable: ["languagesAvailable"],
                 showInitialViewForVersionChange: ["showInitialViewForVersionChange"],
                 ccpa: .mock(),
                 tcf2: .mock(),
                 customization: .mock(),
                 firstLayer: .mock(),
                 styles: .mock(),
                 interactionAnalytics: true,
                 consentAnalytics: true,
                 consentXDevice: true,
                 variants: .mock(),
                 dpsDisplayFormat: .all,
                 framework: .vcdpa,
                 publishedApps: [.mock()],
                 renewConsentsTimestamp: 1000,
                 consentWebhook: true,
                 consentTemplates: [.mock()],
                 categories: [.mock()])
  }
}

extension UsercentricsService {

  static func mock() -> UsercentricsService {
    return .init(templateId: "templateId",
                 version: "version",
                 type: "type",
                 adminSettingsId: ["adminSettingsId"],
                 dataProcessor: "dataProcessor",
                 dataPurposes: ["dataPurposes"],
                 processingCompany: "processingCompany",
                 nameOfProcessingCompany: "nameOfProcessingCompany",
                 addressOfProcessingCompany: "addressOfProcessingCompany",
                 descriptionOfService: "descriptionOfService",
                 technologyUsed: ["technologyUsed"],
                 languagesAvailable: ["languagesAvailable"],
                 dataCollectedList: ["dataCollectedList"],
                 dataPurposesList: ["dataPurposesList"],
                 dataRecipientsList: ["dataRecipientsList"],
                 legalBasisList: ["legalBasisList"],
                 retentionPeriodList: ["retentionPeriodList"],
                 subConsents: ["subConsents"],
                 language: "language",
                 createdBy: "createdBy",
                 updatedBy: "updatedBy",
                 isLatest: true,
                 linkToDpa: "linkToDpa",
                 legalGround: "legalGround",
                 optOutUrl: "optOutUrl",
                 policyOfProcessorUrl: "policyOfProcessorUrl",
                 categorySlug: "categorySlug",
                 recordsOfProcessingActivities: "recordsOfProcessingActivities",
                 retentionPeriodDescription: "retentionPeriodDescription",
                 dataProtectionOfficer: "dataProtectionOfficer",
                 privacyPolicyURL: "privacyPolicyURL",
                 cookiePolicyURL: "cookiePolicyURL",
                 locationOfProcessing: "locationOfProcessing",
                 dataCollectedDescription: "dataCollectedDescription",
                 thirdCountryTransfer: "thirdCountryTransfer",
                 description: "description",
                 cookieMaxAgeSeconds: 123,
                 usesNonCookieAccess: true,
                 deviceStorageDisclosureUrl: "deviceStorageDisclosureUrl",
                 deviceStorage: .mock(),
                 dpsDisplayFormat: "dpsDisplayFormat",
                 isHidden: true,
                 framework: "framework",
                 isDeactivated: true,
                 isAutoUpdateAllowed: true,
                 disableLegalBasis: true,
                 isEssential: true)
  }
}

extension LegalBasisLocalization {

  static func mock() -> LegalBasisLocalization {
    let value = (NSClassFromString("UsercentricsLegalBasisLocalization")?.alloc() as! LegalBasisLocalization)
    return value.doCopy(labels: 123, labelsAria: .mock(), data: ["123": "123"])
  }
}

extension UsercentricsLabels {

  static func mock() -> UsercentricsLabels {
    return .init(btnAcceptAll: "btnAcceptAll",
                 btnDeny: "btnDeny",
                 btnSave: "btnSave",
                 firstLayerTitle: "firstLayerTitle",
                 accepted: "accepted",
                 denied: "denied",
                 date: "date",
                 decision: "decision",
                 dataCollectedList: "dataCollectedList",
                 dataCollectedInfo: "dataCollectedInfo",
                 locationOfProcessing: "locationOfProcessing",
                 transferToThirdCountries: "transferToThirdCountries",
                 transferToThirdCountriesInfo: "transferToThirdCountriesInfo",
                 dataPurposes: "dataPurposes",
                 dataPurposesInfo: "dataPurposesInfo",
                 dataRecipientsList: "dataRecipientsList",
                 descriptionOfService: "descriptionOfService",
                 history: "history",
                 historyDescription: "historyDescription",
                 legalBasisList: "legalBasisList",
                 legalBasisInfo: "legalBasisInfo",
                 processingCompanyTitle: "processingCompanyTitle",
                 retentionPeriod: "retentionPeriod",
                 technologiesUsed: "technologiesUsed",
                 technologiesUsedInfo: "technologiesUsedInfo",
                 cookiePolicyInfo: "cookiePolicyInfo",
                 optOut: "optOut",
                 policyOf: "policyOf",
                 imprintLinkText: "imprintLinkText",
                 privacyPolicyLinkText: "privacyPolicyLinkText",
                 categories: "categories",
                 anyDomain: "anyDomain",
                 day: "day",
                 days: "days",
                 domain: "domain",
                 duration: "duration",
                 informationLoadingNotPossible: "informationLoadingNotPossible",
                 hour: "hour",
                 hours: "hours",
                 identifier: "identifier",
                 maximumAgeCookieStorage: "maximumAgeCookieStorage",
                 minute: "minute",
                 minutes: "minutes",
                 month: "month",
                 months: "months",
                 multipleDomains: "multipleDomains",
                 no: "no",
                 nonCookieStorage: "nonCookieStorage",
                 seconds: "seconds",
                 session: "session",
                 loadingStorageInformation: "loadingStorageInformation",
                 storageInformation: "storageInformation",
                 detailedStorageInformation: "detailedStorageInformation",
                 tryAgain: "tryAgain",
                 type: "type",
                 year: "year",
                 years: "years",
                 yes: "yes",
                 storageInformationDescription: "storageInformationDescription",
                 btnBannerReadMore: "btnBannerReadMore",
                 readLess: "readLess",
                 btnMore: "btnMore",
                 more: "more",
                 linkToDpaInfo: "linkToDpaInfo",
                 second: "second",
                 consent: "consent",
                 headerModal: "headerModal",
                 secondLayerDescriptionHtml: "secondLayerDescriptionHtml",
                 secondLayerTitle: "secondLayerTitle",
                 
                 settings: "settings",
                 subConsents: "subConsents",
                 btnAccept: "btnAccept",
                 poweredBy: "poweredBy",
                 dataProtectionOfficer: "dataProtectionOfficer",
                 nameOfProcessingCompany: "nameOfProcessingCompany",
                 btnBack: "btnBack",
                 copy: "copyLabel",
                 copied: "copied",
                 basic: "basic",
                 advanced: "advanced",
                 processingCompany: "processingCompany",
                 name: "name",
                 explicit: "explicit",
                 implicit: "implicit",
                 btnMoreInfo: "btnMoreInfo",
                 furtherInformationOptOut: "furtherInformationOptOut",
                 cookiePolicyLinkText: "cookiePolicyLinkText",
                 noImplicit: "noImplicit",
                 yesImplicit: "yesImplicit",
                 
                 addressOfProcessingCompany: "addressOfProcessingCompany",
                 consentType: "consentType",
                 consents: "consents",
                 language: "language",
                 less: "less",
                 notAvailable: "notAvailable",
                 technology: "technology",
                 view: "view")
  }
}

extension SecondLayer {

  static func mock() -> SecondLayer {
    return .init(tabsCategoriesLabel: "tabsCategoriesLabel",
                 tabsServicesLabel: "tabsServicesLabel",
                 hideTogglesForServices: true,
                 hideDataProcessingServices: true,
                 hideButtonDeny: true,
                 hideLanguageSwitch: true,
                 acceptButtonText: "acceptButtonText",
                 denyButtonText: "denyButtonText")
  }
}

extension ConsentDisclosureObject {

  static func mock() -> ConsentDisclosureObject {
    return .init(disclosures: [.mock()])
  }
}

extension ConsentDisclosure {

  static func mock() -> ConsentDisclosure {
    return .init(identifier: "identifier",
                 type: .app,
                 name: "name",
                 maxAgeSeconds: 123,
                 cookieRefresh: true,
                 purposes: [1,2,3],
                 domain: "domain",
                 description: "description")
  }
}


extension CCPASettings {

  static func mock() -> CCPASettings {
    return .init(optOutNoticeLabel: "optOutNoticeLabel",
                 btnSave: "btnSave",
                 firstLayerTitle: "firstLayerTitle",
                 secondLayerTitle: "secondLayerTitle",
                 secondLayerDescription: "secondLayerDescription",
                 btnMoreInfo: "btnMoreInfo",
                 firstLayerMobileVariant: .full,
                 isActive: true,
                 region: .all,
                 showOnPageLoad: true,
                 reshowAfterDays: 123,
                 iabAgreementExists: true,
                 removeDoNotSellToggle: true,
                 appFirstLayerDescription: "appFirstLayerDescription",
                 firstLayerMobileDescriptionIsActive: true,
                 firstLayerMobileDescription: "firstLayerMobileDescription",
                 secondLayerHideLanguageSwitch: true)
  }
}

extension TCF2Settings {
  
  static func mock() -> TCF2Settings {
    return .init(firstLayerTitle: "firstLayerTitle",
                 secondLayerTitle: "secondLayerTitle",
                 tabsPurposeLabel: "tabsPurposeLabel",
                 tabsVendorsLabel: "tabsVendorsLabel",
                 labelsFeatures: "labelsFeatures",
                 labelsIabVendors: "labelsIabVendors",
                 labelsNonIabPurposes: "labelsNonIabPurposes",
                 labelsNonIabVendors: "labelsNonIabVendors",
                 labelsPurposes: "labelsPurposes",
                 vendorFeatures: "vendorFeatures",
                 vendorLegitimateInterestPurposes: "vendorLegitimateInterestPurposes",
                 vendorPurpose: "vendorPurpose",
                 vendorSpecialFeatures: "vendorSpecialFeatures",
                 vendorSpecialPurposes: "vendorSpecialPurposes",
                 togglesConsentToggleLabel: "togglesConsentToggleLabel",
                 togglesLegIntToggleLabel: "togglesLegIntToggleLabel",
                 buttonsAcceptAllLabel: "buttonsAcceptAllLabel",
                 buttonsDenyAllLabel: "buttonsDenyAllLabel",
                 buttonsSaveLabel: "buttonsSaveLabel",
                 linksManageSettingsLabel: "linksManageSettingsLabel",
                 linksVendorListLinkLabel: "linksVendorListLinkLabel",
                 togglesSpecialFeaturesToggleOn: "togglesSpecialFeaturesToggleOn",
                 togglesSpecialFeaturesToggleOff: "togglesSpecialFeaturesToggleOff",
                 firstLayerMobileVariant: .full,
                 firstLayerHideToggles: true,
                 secondLayerHideToggles: true,
                 hideLegitimateInterestToggles: true,
                 categoriesOfDataLabel: "categoriesOfDataLabel",
                 dataRetentionPeriodLabel: "dataRetentionPeriodLabel",
                 legitimateInterestLabel: "legitimateInterestLabel",
                 version: "version",
                 examplesLabel: "examplesLabel",
                 cmpId: 123,
                 cmpVersion: 123,
                 showDataSharedOutsideEUText: true,
                 dataSharedOutsideEUText: "dataSharedOutsideEUText",
                 vendorIdsOutsideEUList: [1,2,3],
                 firstLayerHideButtonDeny: true,
                 hideButtonManageSettings: false,
                 secondLayerHideButtonDeny: true,
                 publisherCountryCode: "publisherCountryCode",
                 purposeOneTreatment: true,
                 selectedVendorIds: [1,2,3],
                 gdprApplies: true,
                 selectedStacks: [1,2,3],
                 scope: .global,
                 disabledSpecialFeatures: [1,2,3],
                 firstLayerShowDescriptions: true,
                 hideNonIabOnFirstLayer: true,
                 resurfacePeriodEnded: true,
                 resurfacePurposeChanged: true,
                 resurfaceVendorAdded: true,
                 firstLayerDescription: "firstLayerDescription",
                 firstLayerAdditionalInfo: "firstLayerAdditionalInfo",
                 secondLayerDescription: "secondLayerDescription",
                 appLayerNoteResurface: "appLayerNoteResurface",
                 firstLayerNoteResurface: "firstLayerNoteResurface",
                 changedPurposes: .mock(),
                 acmV2Enabled: true,
                 selectedATPIds: [43,46,55],
                 resurfaceATPListChanged: false,
                 atpListTitle: "Google Providers",
                 maintainLegitimateInterest: false)
  }
}

extension UsercentricsCustomization {

  static func mock() -> UsercentricsCustomization {
    return .init(logoUrl: "logoUrl",
                 borderRadiusLayer: 123,
                 borderRadiusButton: 123,
                 overlayOpacity: 123,
                 font: .mock(),
                 color: .mock(),
                 logoAltTag: "logoAltTag",
                 buttonAlignment: "center")
  }
}

extension FirstLayer {

  static func mock() -> FirstLayer {
    return .init(hideButtonDeny: true,
                 logoPosition: .center,
                 secondLayerTrigger: .button,
                 closeOption: .icon,
                 mobileVariant: .full)
  }
}

extension UsercentricsStyles {

  static func mock() -> UsercentricsStyles {
    return .init(btnPrivacyButtonInactiveSize: 123,
                 historyDateFormat: 123,
                 btnPrivacyButtonActiveSize: 123,
                 txtOptInMsgFontSize: 123,
                 btnPrivacyButtonTransparency: 123,
                 btnPrivacyButtonBgColor: "btnPrivacyButtonBgColor",
                 btnAcceptTextColor: "btnAcceptTextColor",
                 btnDenyTextColor: "btnDenyTextColor",
                 txtOptInMsgColor: "txtOptInMsgColor",
                 btnMoreInfoBgColor: "btnMoreInfoBgColor",
                 btnMoreInfoTextColor: "btnMoreInfoTextColor",
                 btnAcceptBgColor: "btnAcceptBgColor",
                 btnDenyBgColor: "btnDenyBgColor",
                 linkColor: "linkColor",
                 cornerModalHeaderBgColor: "cornerModalHeaderBgColor",
                 cornerModalHeaderTextColor: "cornerModalHeaderTextColor",
                 privacyModalHeaderBgColor: "privacyModalHeaderBgColor",
                 privacyModalHeaderTextColor: "privacyModalHeaderTextColor",
                 bannerBgColor: "bannerBgColor",
                 bannerTextColor: "bannerTextColor",
                 btnPrivacyButtonTextColor: "btnPrivacyButtonTextColor",
                 modalSaveTextColor: "modalSaveTextColor",
                 modalSaveBgColor: "modalSaveBgColor",
                 chipTextColor: "chipTextColor",
                 chipBgColor: "chipBgColor")
  }
}

extension VariantsSettings {

  static func mock() -> VariantsSettings {
    return .init(enabled: true,
                 experimentsJson: "experimentsJson",
                 activateWith: "activateWith")
  }
}

extension PublishedApp {

  static func mock() -> PublishedApp {
    return .init(bundleId: "bundleId",
                 platform: .ios)
  }
}

extension ServiceConsentTemplate {

  static func mock() -> ServiceConsentTemplate {
    return .init(isDeactivated: true,
                 defaultConsentStatus: true,
                 templateId: "templateId",
                 version: "version",
                 categorySlug: "categorySlug",
                 description: "description",
                 isHidden: true,
                 subConsents: [.mock()],
                 isAutoUpdateAllowed: true,
                 legalBasisList: ["legalBasisList"],
                 disableLegalBasis: true)
  }
}

extension SubConsentTemplate {

  static func mock() -> SubConsentTemplate {
    return .init(isDeactivated: true,
                 defaultConsentStatus: true,
                 templateId: "templateId",
                 version: "version",
                 categorySlug: "categorySlug",
                 description: "description",
                 isHidden: true)
  }
}


extension UsercentricsCategory {

  static func mock() -> UsercentricsCategory {
    return .init(categorySlug: "categorySlug",
                 label: "label",
                 description: "description",
                 isEssential: true,
                 isHidden: true)
  }
}

extension TCF2ChangedPurposes {

  static func mock() -> TCF2ChangedPurposes {
    return .init(purposes: [1,2,3], legIntPurposes: [1,2,3], notAllowedPurposes: [1,2,3])
  }
}


extension CustomizationFont {

  static func mock() -> CustomizationFont {
    return .init(family: "family", size: 123)
  }
}

extension CustomizationColor {

  static func mock() -> CustomizationColor {
    return .init(primary: "primary",
                 acceptBtnText: "acceptBtnText",
                 acceptBtnBackground: "acceptBtnBackground",
                 denyBtnText: "denyBtnText",
                 denyBtnBackground: "denyBtnBackground",
                 saveBtnText: "saveBtnText",
                 saveBtnBackground: "saveBtnBackground",
                 linkIcon: "linkIcon",
                 linkFont: "linkFont",
                 text: "text",
                 layerBackground: "layerBackground",
                 overlay: "overlay",
                 toggleInactiveBackground: "toggleInactiveBackground",
                 toggleInactiveIcon: "toggleInactiveIcon",
                 toggleActiveBackground: "toggleActiveBackground",
                 toggleActiveIcon: "toggleActiveIcon",
                 toggleDisabledBackground: "toggleDisabledBackground",
                 toggleDisabledIcon: "toggleDisabledIcon",
                 secondLayerTab: "secondLayerTab",
                 tabsBorderColor: "tabsBorderColor",
                 ccpaButtonColor: "ccpaButtonColor",
                 ccpaButtonTextColor: "ccpaButtonTextColor")
  }
}

extension TranslationAriaLabels {

  static func mock() -> TranslationAriaLabels {
    return .init(acceptAllButton: "acceptAllButton",
                 ccpaButton: "ccpaButton",
                 ccpaMoreInformation: "ccpaMoreInformation",
                 closeButton: "closeButton",
                 collapse: "collapse",
                 cookiePolicyButton: "cookiePolicyButton",
                 copyControllerId: "copyControllerId",
                 denyAllButton: "denyAllButton",
                 expand: "expand",
                 fullscreenButton: "fullscreenButton",
                 imprintButton: "imprintButton",
                 languageSelector: "languageSelector",
                 privacyButton: "privacyButton",
                 privacyPolicyButton: "privacyPolicyButton",
                 saveButton: "saveButton",
                 serviceInCategoryDetails: "serviceInCategoryDetails",
                 servicesInCategory: "servicesInCategory",
                 tabButton: "tabButton",
                 usercentricsCMPButtons: "usercentricsCMPButtons",
                 usercentricsCMPContent: "usercentricsCMPContent",
                 usercentricsCMPHeader: "usercentricsCMPHeader",
                 usercentricsCMPUI: "usercentricsCMPUI",
                 usercentricsCard: "usercentricsCard",
                 usercentricsList: "usercentricsList",
                 vendorConsentToggle: "vendorConsentToggle",
                 vendorDetailedStorageInformation: "vendorDetailedStorageInformation",
                 vendorLegIntToggle: "vendorLegIntToggle")
  }
}


extension UsercentricsLocation {
  
  static func mock() -> UsercentricsLocation {
    return UsercentricsLocation(countryCode: "PT", regionCode: "")
  }
}

