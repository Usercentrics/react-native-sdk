package com.usercentrics.reactnativemodule.mock

import com.usercentrics.sdk.AdTechProvider
import com.usercentrics.sdk.AdditionalConsentModeData
import com.usercentrics.sdk.models.settings.USAFrameworks
import com.usercentrics.sdk.v2.location.data.UsercentricsLocation
import com.usercentrics.sdk.v2.settings.data.CCPASettings
import com.usercentrics.sdk.v2.settings.data.ConsentDisclosure
import com.usercentrics.sdk.v2.settings.data.ConsentDisclosureObject
import com.usercentrics.sdk.v2.settings.data.ConsentDisclosureType
import com.usercentrics.sdk.v2.settings.data.CustomizationColor
import com.usercentrics.sdk.v2.settings.data.CustomizationFont
import com.usercentrics.sdk.v2.settings.data.DpsDisplayFormat
import com.usercentrics.sdk.v2.settings.data.FirstLayer
import com.usercentrics.sdk.v2.settings.data.FirstLayerMobileVariant
import com.usercentrics.sdk.v2.settings.data.PublishedApp
import com.usercentrics.sdk.v2.settings.data.PublishedAppPlatform
import com.usercentrics.sdk.v2.settings.data.SecondLayer
import com.usercentrics.sdk.v2.settings.data.TCF2ChangedPurposes
import com.usercentrics.sdk.v2.settings.data.TCF2Scope
import com.usercentrics.sdk.v2.settings.data.TCF2Settings
import com.usercentrics.sdk.v2.settings.data.UsercentricsCategory
import com.usercentrics.sdk.v2.settings.data.UsercentricsCustomization
import com.usercentrics.sdk.v2.settings.data.UsercentricsLabels
import com.usercentrics.sdk.v2.settings.data.UsercentricsService
import com.usercentrics.sdk.v2.settings.data.UsercentricsSettings
import com.usercentrics.sdk.v2.settings.data.VariantsSettings
import com.usercentrics.sdk.v2.translation.data.TranslationAriaLabels

internal object GetCMPDataMock {

    val fakeCategories = listOf(
        UsercentricsCategory(
            categorySlug = "essential",
            description = "These technologies are required to activate the core functionality of the website.",
            isEssential = true,
            label = "Essential",
        )
    )
    val fakeUserLocation = UsercentricsLocation(
        countryCode = "PT",
        regionCode = ""
    )
    val fakeServices = listOf(
        UsercentricsService(
            templateId = "ABC",
            version = "1.2.3",
            type = "predefined",
            dataProcessor = "Google Ads",
            dataPurposes = listOf("Advertising Conversion Tracking"),
            processingCompany = "Google Ireland Limited, Google Building Gordon House",
            nameOfProcessingCompany = "Google Ireland Limited",
            addressOfProcessingCompany = "Google Building Gordon House",
            descriptionOfService = "This is a conversion tracking service. ",
            languagesAvailable = listOf("en"),
            dataCollectedList = listOf("IP adress"),
            dataPurposesList = listOf("Analytics"),
            dataRecipientsList = listOf("Google Ireland Limited"),
            legalBasisList = listOf("Art. 6 para. 1 s. 1 lit. a GDPR"),
            retentionPeriodList = listOf(),
            subConsents = listOf(),
            language = "en",
            linkToDpa = "",
            legalGround = "Art. 6 para. 1 s. 1 lit. c GDPR",
            optOutUrl = "",
            policyOfProcessorUrl = "https://usercentrics.com/de/datenschutzerklarung/",
            categorySlug = "essential",
            retentionPeriodDescription = "The consent data (given consent and revocation of consent) are stored for three years. The data will then be deleted immediately or given to the person responsible on request in the form of a data export.",
            dataProtectionOfficer = "datenschutz@usercentrics.com",
            privacyPolicyURL = "https://usercentrics.com/privacy-policy/",
            cookiePolicyURL = "",
            locationOfProcessing = "European Union",
            dataCollectedDescription = "",
            thirdCountryTransfer = "Worldwide",
            description = "",
            isDeactivated = false,
            disableLegalBasis = false,
            technologyUsed = listOf("Cookies", "Pixel Tags"),
            deviceStorage = ConsentDisclosureObject(
                disclosures = listOf(
                    ConsentDisclosure(
                        identifier = "identifier",
                        type = ConsentDisclosureType.APP,
                        name = "name",
                        maxAgeSeconds = 123123,
                        cookieRefresh = true,
                        purposes = listOf(1, 2, 3),
                        domain = "domain",
                        description = "description",
                    )
                )
            ),
            isHidden = false,
        )
    )
    private val fakeLabels = UsercentricsLabels(
        btnAcceptAll = "Accept All",
        btnDeny = "Deny",
        btnSave = "Save Services",
        firstLayerTitle = "Privacy Settings",
        accepted = "yes",
        denied = "no",
        date = "Date",
        decision = "Decision",
        dataCollectedList = "Data Collected",
        dataCollectedInfo = "This list represents all (personal) data that is collected by or through the use of this service.",
        locationOfProcessing = "Location of Processing",
        transferToThirdCountries = "Transfer to Third Countries",
        transferToThirdCountriesInfo = "This service may forward the collected data to a different country.",
        dataPurposes = "Data Purposes",
        dataPurposesInfo = "This list represents the purposes of the data collection and processing.",
        dataRecipientsList = "Data Recipients",
        descriptionOfService = "Description of Service",
        history = "History",
        historyDescription = "",
        legalBasisList = "Legal Basis",
        legalBasisInfo = "In the following the required legal basis for the processing of data is listed.",
        processingCompanyTitle = "Processing Company",
        retentionPeriod = "Retention Period",
        technologiesUsed = "Technologies Used",
        technologiesUsedInfo = "This list represents all technologies this service uses to collect data. Typical technologies are Cookies and Pixels that are placed in the browser.",
        cookiePolicyInfo = "Click here to read the cookie policy of the data processor",
        optOut = "Click here to opt out from this processor across all domains",
        policyOf = "Click here to read the privacy policy of the data processor",
        imprintLinkText = "Imprint",
        privacyPolicyLinkText = "Privacy Policy",
        categories = "Categories",
        anyDomain = "any domain (ex. first party cookie)",
        day = "day",
        days = "days",
        domain = "Domain",
        duration = "Duration",
        informationLoadingNotPossible = "Sorry, we could not load the required information.",
        hour = "hour",
        hours = "hours",
        identifier = "Identifier",
        maximumAgeCookieStorage = "Maximum age of cookie storage",
        minute = "minute",
        minutes = "minutes",
        month = "month",
        months = "months",
        multipleDomains = "multiple subdomains may exist",
        no = "no",
        nonCookieStorage = "Non-cookie storage",
        seconds = "seconds",
        session = "Session",
        loadingStorageInformation = "Loading storage information",
        storageInformation = "Storage Information",
        detailedStorageInformation = "Detailed Storage Information",
        tryAgain = "Try again?",
        type = "Type",
        year = "year",
        years = "years",
        yes = "yes",
        storageInformationDescription = "Below you can see the longest potential duration for storage on a device, as set when using the cookie method of storage and if there are any other methods used.",
        btnBannerReadMore = "Read more",
        btnMore = "more",
        more = "more",
        linkToDpaInfo = "Data Processing Agreement",
        second = "second",
        consent = "Consent",
        headerModal = "This tool helps you to select and deactivate various tags / trackers / analytic tools used on this website.",
        secondLayerDescriptionHtml = "Privacy Settings Description",
        secondLayerTitle = "Privacy Settings Title",

        // Optional
        settings = "Settings",
        subConsents = "Subservices",
        btnAccept = "Accept",
        poweredBy = "Powered by <a href=\"https://usercentrics.com/?utm_source=cmp&utm_medium=powered_by\" rel=\"nofollow\" target=\"_blank\">Usercentrics Consent Management</a>",
        dataProtectionOfficer = "Data Protection Officer of Processing Company",
        nameOfProcessingCompany = "Processing Company",
        btnBack = "Back",
        copy = "copyLabel",
        copied = "copied",
        basic = "Basic",
        advanced = "Advanced",
        processingCompany = "Processing Company",
        name = "Name",
        explicit = "Explicit",
        implicit = "Implicit",
        btnMoreInfo = "More Info",
        furtherInformationOptOut = "Further Information and Opt-Out",
        cookiePolicyLinkText = "Cookie Policy",
        noImplicit = "no (default)",
        yesImplicit = "yes (implicit)",

        addressOfProcessingCompany = "Address of processing company",
        consentType = "Consent type",
        consents = "Consents",
        language = "Language",

        less = "less",
        notAvailable = "not available",
        technology = "Technology being used to process the data",
        view = "view",
    )
    private val fakeFirstLayer = FirstLayer(
        hideButtonDeny = false,
    )
    private val fakeSecondLayer = SecondLayer(
        tabsServicesLabel = "Services",
        hideLanguageSwitch = false,
        tabsCategoriesLabel = "Categories",
        hideButtonDeny = false,
        acceptButtonText = "Accept All",
        denyButtonText = "Deny All",
        hideTogglesForServices = false,
        hideDataProcessingServices = false,
    )
    private val fakeTCF2Settings = TCF2Settings(
        togglesSpecialFeaturesToggleOff = "Off",
        secondLayerTitle = "Privacy Settings Title",
        tabsVendorsLabel = "Vendors",
        labelsIabVendors = "Vendors who are part of the IAB TCF",
        buttonsDenyAllLabel = "Deny all",
        resurfacePeriodEnded = true,
        vendorSpecialPurposes = "Special Purposes",
        firstLayerAdditionalInfo = "",
        resurfaceVendorAdded = true,
        disabledSpecialFeatures = listOf(),
        resurfacePurposeChanged = true,
        firstLayerHideButtonDeny = false,
        hideLegitimateInterestToggles = false,
        secondLayerHideButtonDeny = false,
        secondLayerHideToggles = false,
        togglesConsentToggleLabel = "Consent",
        labelsFeatures = "Features",
        togglesSpecialFeaturesToggleOn = "On",
        vendorSpecialFeatures = "Special Features",
        appLayerNoteResurface =
        "You can change your privacy settings or withdraw your consent at any time by opening the menu point Privacy Settings.",
        cmpVersion = 3,
        firstLayerDescription =
        "We and our third-party vendors use technologies (e.g. cookies) to store and/or access information on user's devices in order to process personal data such as IP addresses or browsing data. You may consent to the processing of your personal data for the listed purposes below. Alternatively you can set your preferences before consenting or refuse to consent. Please note that some vendors may process your personal data based on their legitimate business interest and do not ask for your consent. To exercise your right to object to processing based on legitimate interest please view our vendorlist.",
        firstLayerShowDescriptions = false,
        labelsPurposes = "Purposes",
        firstLayerNoteResurface =
        "You can change your privacy settings or withdraw your consent at any time by clicking on our Privacy Button.",
        firstLayerTitle = "Privacy Information",
        vendorLegitimateInterestPurposes = "Purposes processed by Legitimate Interest",
        selectedStacks = listOf(),
        labelsNonIabPurposes = "Non-IAB Purposes",
        togglesLegIntToggleLabel = "Legitimate Interest",
        vendorPurpose = "Purposes processed by Consent",
        labelsNonIabVendors = "Vendors who are not part of the IAB TCF",
        purposeOneTreatment = false,
        cmpId = 5,
        vendorFeatures = "Features",
        secondLayerDescription =
        "You can access more detailed information below regarding all purposes and third-party vendors implemented on this website. You can adjust your privacy settings based on specific purposes and/or at a vendor level at any time.",
        publisherCountryCode = "DE",
        buttonsSaveLabel = "Save Settings",
        selectedVendorIds = listOf(),
        buttonsAcceptAllLabel = "Accept all",
        hideNonIabOnFirstLayer = false,
        linksManageSettingsLabel = "Manage Settings",
        firstLayerHideToggles = false,
        gdprApplies = true,
        linksVendorListLinkLabel = "Vendorlist",
        tabsPurposeLabel = "Purposes",
        version = "2.2",
        categoriesOfDataLabel = "categoriesOfDataLabel",
        dataRetentionPeriodLabel = "dataRetentionPeriodLabel",
        legitimateInterestLabel = "legitimateInterestLabel",
        examplesLabel = "examplesLabel",
        firstLayerMobileVariant = FirstLayerMobileVariant.FULL,
        showDataSharedOutsideEUText = true,
        dataSharedOutsideEUText = "dataSharedOutsideEUText",
        vendorIdsOutsideEUList = listOf(1, 2, 3),
        scope = TCF2Scope.SERVICE,
        changedPurposes = TCF2ChangedPurposes(purposes = listOf(1, 2, 3), legIntPurposes = listOf(1, 2, 3)),
        acmV2Enabled = true,
        selectedATPIds = listOf(43, 46, 55),
        atpListTitle = "Google Providers",
    )
    private val fakeCCPASettings = CCPASettings(
        secondLayerHideLanguageSwitch = false,
        secondLayerTitle = "Privacy Settings Title",
        iabAgreementExists = false,
        optOutNoticeLabel = "Do not sell my personal information",
        btnSave = "OK",
        showOnPageLoad = false,
        btnMoreInfo = "More Information",
        firstLayerTitle = "Privacy Information",
        appFirstLayerDescription =
        "We and our partners are using technologies like cookies and process personal data in order to improve your experience. In case of sale of your personal information you may exercise your consumer right to opt-out by activating the toggle 'Do Not Sell My Personal Information' below. For detailed information about the categories of personal information we collect and the purposes for which information may be used and which Data Processing Services may have access to this information please refer to our privacy policy.",
        isActive = false,
        secondLayerDescription =
        "Here you can find detailed information about the categories of personal information we collect and the purposes for which information may be used and which Data Processing Services may have access to this information.",
        firstLayerMobileDescriptionIsActive = false,
        reshowAfterDays = 365,
        firstLayerMobileDescription =
        "We and our partners are using technologies like cookies and process personal data in order to improve your experience. In case of sale of your personal information you may exercise your consumer right to opt-out by activating the toggle 'Do Not Sell My Personal Information' below.",
    )
    private val fakeCustomization = UsercentricsCustomization(
        color = CustomizationColor(
            primary = "0045A5"
        ),
        font = CustomizationFont(
            size = 14,
            family =
            "BlinkMacSystemFont,-apple-system,Segoe UI,Roboto,Oxygen-Sans,Ubuntu,Cantarell,Fira Sans,Droid Sans,Helvetica Neue,Helvetica,Arial,sans-serif"
        ),
        logoUrl = "https://www.munich-startup.de/wp-content/uploads/2018/01/usercentrics-logo-4c@4x.png"
    )

    val fakeSettings = UsercentricsSettings(
        labels = fakeLabels,
        showInitialViewForVersionChange = listOf(),
        displayOnlyForEU = false,
        secondLayer = fakeSecondLayer,
        cookiePolicyUrl = "",
        tcf2 = fakeTCF2Settings,
        ccpa = fakeCCPASettings,
        privacyPolicyUrl = "https://usercentrics.com/privacy-policy/",
        firstLayer = fakeFirstLayer,
        imprintUrl = "https://usercentrics.com/legal-notice/",
        firstLayerDescriptionHtml = "Privacy Settings test description.",
        bannerMobileDescriptionIsActive = false,
        firstLayerMobileDescriptionHtml = "",
        version = "6.0.4",
        language = "en",
        tcf2Enabled = false,
        settingsId = "lQ_Dio7QL",
        languagesAvailable = listOf("en", "de"),
        enablePoweredBy = true,
        editableLanguages = listOf("en", "de"),
        customization = fakeCustomization,
        variants = VariantsSettings(enabled = true, experimentsJson = "{}", activateWith = "UC"),
        dpsDisplayFormat = DpsDisplayFormat.ALL,
        framework = USAFrameworks.CTDPA,
        publishedApps = listOf(
            PublishedApp(bundleId = "bundleId", platform = PublishedAppPlatform.ANDROID)
        ),
    )

    // From the debugger
    private val expectedFirstLayer = hashMapOf(
        "hideButtonDeny" to false,
    )
    private val expectedSecondLayer = hashMapOf(
        "tabsCategoriesLabel" to "Categories",
        "tabsServicesLabel" to "Services",
        "hideButtonDeny" to false,
        "hideLanguageSwitch" to false,
        "acceptButtonText" to "Accept All",
        "denyButtonText" to "Deny All",
        "hideTogglesForServices" to false,
        "hideDataProcessingServices" to false,
    )

    private val expectedLabels = hashMapOf(
        "btnAcceptAll" to "Accept All",
        "btnDeny" to "Deny",
        "btnSave" to "Save Services",
        "firstLayerTitle" to "Privacy Settings",
        "accepted" to "yes",
        "denied" to "no",
        "date" to "Date",
        "decision" to "Decision",
        "dataCollectedList" to "Data Collected",
        "dataCollectedInfo" to "This list represents all (personal) data that is collected by or through the use of this service.",
        "locationOfProcessing" to "Location of Processing",
        "transferToThirdCountries" to "Transfer to Third Countries",
        "transferToThirdCountriesInfo" to "This service may forward the collected data to a different country.",
        "dataPurposes" to "Data Purposes",
        "dataPurposesInfo" to "This list represents the purposes of the data collection and processing.",
        "dataRecipientsList" to "Data Recipients",
        "descriptionOfService" to "Description of Service",
        "history" to "History",
        "historyDescription" to "",
        "legalBasisList" to "Legal Basis",
        "legalBasisInfo" to "In the following the required legal basis for the processing of data is listed.",
        "processingCompanyTitle" to "Processing Company",
        "retentionPeriod" to "Retention Period",
        "technologiesUsed" to "Technologies Used",
        "technologiesUsedInfo" to "This list represents all technologies this service uses to collect data. Typical technologies are Cookies and Pixels that are placed in the browser.",
        "cookiePolicyInfo" to "Click here to read the cookie policy of the data processor",
        "optOut" to "Click here to opt out from this processor across all domains",
        "policyOf" to "Click here to read the privacy policy of the data processor",
        "imprintLinkText" to "Imprint",
        "privacyPolicyLinkText" to "Privacy Policy",
        "categories" to "Categories",
        "anyDomain" to "any domain (ex. first party cookie)",
        "day" to "day",
        "days" to "days",
        "domain" to "Domain",
        "duration" to "Duration",
        "informationLoadingNotPossible" to "Sorry, we could not load the required information.",
        "hour" to "hour",
        "hours" to "hours",
        "identifier" to "Identifier",
        "maximumAgeCookieStorage" to "Maximum age of cookie storage",
        "minute" to "minute",
        "minutes" to "minutes",
        "month" to "month",
        "months" to "months",
        "multipleDomains" to "multiple subdomains may exist",
        "no" to "no",
        "nonCookieStorage" to "Non-cookie storage",
        "seconds" to "seconds",
        "session" to "Session",
        "loadingStorageInformation" to "Loading storage information",
        "storageInformation" to "Storage Information",
        "detailedStorageInformation" to "Detailed Storage Information",
        "tryAgain" to "Try again?",
        "type" to "Type",
        "year" to "year",
        "years" to "years",
        "yes" to "yes",
        "storageInformationDescription" to "Below you can see the longest potential duration for storage on a device, as set when using the cookie method of storage and if there are any other methods used.",
        "btnBannerReadMore" to "Read more",
        "btnMore" to "more",
        "more" to "more",
        "linkToDpaInfo" to "Data Processing Agreement",
        "second" to "second",
        "consent" to "Consent",
        "headerModal" to "This tool helps you to select and deactivate various tags / trackers / analytic tools used on this website.",
        "secondLayerDescriptionHtml" to "Privacy Settings Description",
        "secondLayerTitle" to "Privacy Settings Title",

        // Optional
        "settings" to "Settings",
        "subConsents" to "Subservices",
        "btnAccept" to "Accept",
        "poweredBy" to "Powered by <a href=\"https://usercentrics.com/?utm_source=cmp&utm_medium=powered_by\" rel=\"nofollow\" target=\"_blank\">Usercentrics Consent Management</a>",
        "dataProtectionOfficer" to "Data Protection Officer of Processing Company",
        "nameOfProcessingCompany" to "Processing Company",
        "btnBack" to "Back",
        "copy" to "copyLabel",
        "copied" to "copied",
        "basic" to "Basic",
        "advanced" to "Advanced",
        "processingCompany" to "Processing Company",
        "name" to "Name",
        "explicit" to "Explicit",
        "implicit" to "Implicit",
        "btnMoreInfo" to "More Info",
        "furtherInformationOptOut" to "Further Information and Opt-Out",
        "cookiePolicyLinkText" to "Cookie Policy",
        "noImplicit" to "no (default)",
        "yesImplicit" to "yes (implicit)",
    )
    private val expectedTCF2Settings = hashMapOf(
        "firstLayerTitle" to "Privacy Information",
        "secondLayerTitle" to "Privacy Settings Title",
        "tabsPurposeLabel" to "Purposes",
        "tabsVendorsLabel" to "Vendors",
        "labelsFeatures" to "Features",
        "labelsIabVendors" to "Vendors who are part of the IAB TCF",
        "labelsNonIabPurposes" to "Non-IAB Purposes",
        "labelsNonIabVendors" to "Vendors who are not part of the IAB TCF",
        "labelsPurposes" to "Purposes",
        "vendorFeatures" to "Features",
        "vendorLegitimateInterestPurposes" to "Purposes processed by Legitimate Interest",
        "vendorPurpose" to "Purposes processed by Consent",
        "vendorSpecialFeatures" to "Special Features",
        "vendorSpecialPurposes" to "Special Purposes",
        "togglesConsentToggleLabel" to "Consent",
        "togglesLegIntToggleLabel" to "Legitimate Interest",
        "buttonsAcceptAllLabel" to "Accept all",
        "buttonsDenyAllLabel" to "Deny all",
        "buttonsSaveLabel" to "Save Settings",
        "linksManageSettingsLabel" to "Manage Settings",
        "linksVendorListLinkLabel" to "Vendorlist",
        "cmpId" to 5,
        "cmpVersion" to 3,
        "firstLayerHideToggles" to false,
        "secondLayerHideToggles" to false,
        "hideLegitimateInterestToggles" to false,
        "firstLayerHideButtonDeny" to false,
        "secondLayerHideButtonDeny" to false,
        "publisherCountryCode" to "DE",
        "purposeOneTreatment" to false,
        "selectedVendorIds" to listOf<Any>(),
        "gdprApplies" to true,
        "selectedStacks" to listOf<Any>(),
        "disabledSpecialFeatures" to listOf<Any>(),
        "firstLayerShowDescriptions" to false,
        "hideNonIabOnFirstLayer" to false,
        "resurfacePeriodEnded" to true,
        "resurfacePurposeChanged" to true,
        "resurfaceVendorAdded" to true,
        "firstLayerDescription" to "We and our third-party vendors use technologies (e.g. cookies) to store and/or access information on user's devices in order to process personal data such as IP addresses or browsing data. You may consent to the processing of your personal data for the listed purposes below. Alternatively you can set your preferences before consenting or refuse to consent. Please note that some vendors may process your personal data based on their legitimate business interest and do not ask for your consent. To exercise your right to object to processing based on legitimate interest please view our vendorlist.",
        "firstLayerAdditionalInfo" to "",
        "secondLayerDescription" to "You can access more detailed information below regarding all purposes and third-party vendors implemented on this website. You can adjust your privacy settings based on specific purposes and/or at a vendor level at any time.",
        "togglesSpecialFeaturesToggleOn" to "On",
        "togglesSpecialFeaturesToggleOff" to "Off",
        "appLayerNoteResurface" to "You can change your privacy settings or withdraw your consent at any time by opening the menu point Privacy Settings.",
        "firstLayerNoteResurface" to "You can change your privacy settings or withdraw your consent at any time by clicking on our Privacy Button.",
        "categoriesOfDataLabel" to "categoriesOfDataLabel",
        "dataRetentionPeriodLabel" to "dataRetentionPeriodLabel",
        "legitimateInterestLabel" to "legitimateInterestLabel",
        "examplesLabel" to "examplesLabel",
        "version" to "2.2",
        "firstLayerMobileVariant" to 1,
        "showDataSharedOutsideEUText" to true,
        "dataSharedOutsideEUText" to "dataSharedOutsideEUText",
        "vendorIdsOutsideEUList" to listOf(1, 2, 3),
        "scope" to 1,
        "changedPurposes" to mapOf(
            "purposes" to listOf(1, 2, 3),
            "legIntPurposes" to listOf(1, 2, 3),
        ),
        "acmV2Enabled" to true,
        "selectedATPIds" to listOf(43, 46, 55)
    )
    private val expectedCCPASettings = hashMapOf(
        "optOutNoticeLabel" to "Do not sell my personal information",
        "btnSave" to "OK",
        "firstLayerTitle" to "Privacy Information",
        "isActive" to false,
        "showOnPageLoad" to false,
        "reshowAfterDays" to 365,
        "iabAgreementExists" to false,
        "appFirstLayerDescription" to "We and our partners are using technologies like cookies and process personal data in order to improve your experience. In case of sale of your personal information you may exercise your consumer right to opt-out by activating the toggle 'Do Not Sell My Personal Information' below. For detailed information about the categories of personal information we collect and the purposes for which information may be used and which Data Processing Services may have access to this information please refer to our privacy policy.",
        "firstLayerMobileDescriptionIsActive" to false,
        "firstLayerMobileDescription" to "We and our partners are using technologies like cookies and process personal data in order to improve your experience. In case of sale of your personal information you may exercise your consumer right to opt-out by activating the toggle 'Do Not Sell My Personal Information' below.",
        "secondLayerTitle" to "Privacy Settings Title",
        "secondLayerDescription" to "Here you can find detailed information about the categories of personal information we collect and the purposes for which information may be used and which Data Processing Services may have access to this information.",
        "secondLayerHideLanguageSwitch" to false,
        "btnMoreInfo" to "More Information",
    )
    private val expectedCustomization = hashMapOf(
        "color" to hashMapOf(
            "primary" to "0045A5",
        ),
        "font" to hashMapOf(
            "family" to "BlinkMacSystemFont,-apple-system,Segoe UI,Roboto,Oxygen-Sans,Ubuntu,Cantarell,Fira Sans,Droid Sans,Helvetica Neue,Helvetica,Arial,sans-serif",
            "size" to 14
        ),
        "logoUrl" to "https://www.munich-startup.de/wp-content/uploads/2018/01/usercentrics-logo-4c@4x.png",
    )

    val expectedSettings = hashMapOf(
        "labels" to expectedLabels,
        "showInitialViewForVersionChange" to listOf<Any>(),
        "displayOnlyForEU" to false,
        "secondLayer" to expectedSecondLayer,
        "cookiePolicyUrl" to "",
        "tcf2" to expectedTCF2Settings,
        "ccpa" to expectedCCPASettings,
        "privacyPolicyUrl" to "https://usercentrics.com/privacy-policy/",
        "firstLayer" to expectedFirstLayer,
        "imprintUrl" to "https://usercentrics.com/legal-notice/",
        "firstLayerDescriptionHtml" to "Privacy Settings test description.",
        "bannerMobileDescriptionIsActive" to false,
        "firstLayerMobileDescriptionHtml" to "",
        "version" to "6.0.4",
        "language" to "en",
        "tcf2Enabled" to false,
        "settingsId" to "lQ_Dio7QL",
        "languagesAvailable" to listOf("en", "de"),
        "enablePoweredBy" to true,
        "editableLanguages" to listOf("en", "de"),
        "customization" to expectedCustomization,
        "variants" to mapOf(
            "enabled" to true,
            "experimentsJson" to "{}",
            "activateWith" to "UC"
        ),
        "dpsDisplayFormat" to 0,
        "framework" to 3,
        "publishedApps" to listOf(
            mapOf(
                "bundleId" to "bundleId",
                "platform" to 0
            )
        ),
        "reshowBanner" to 0
    )

    val expectedCategories = listOf(
        hashMapOf(
            "categorySlug" to "essential",
            "label" to "Essential",
            "description" to "These technologies are required to activate the core functionality of the website.",
            "isEssential" to true,
        )
    )
    val expectedUserLocation = hashMapOf(
        "countryCode" to "PT",
        "regionCode" to "",
        "isInEU" to true,
        "isInUS" to false,
        "isInCalifornia" to false,
    )
    val expectedServices = listOf(
        hashMapOf(
            "templateId" to "ABC",
            "version" to "1.2.3",
            "type" to "predefined",
            "isEssential" to false,
            "dataProcessor" to "Google Ads",
            "dataPurposes" to listOf("Advertising Conversion Tracking"),
            "processingCompany" to "Google Ireland Limited, Google Building Gordon House",
            "nameOfProcessingCompany" to "Google Ireland Limited",
            "addressOfProcessingCompany" to "Google Building Gordon House",
            "descriptionOfService" to "This is a conversion tracking service. ",
            "languagesAvailable" to listOf("en"),
            "dataCollectedList" to listOf("IP adress"),
            "dataPurposesList" to listOf("Analytics"),
            "dataRecipientsList" to listOf("Google Ireland Limited"),
            "legalBasisList" to listOf("Art. 6 para. 1 s. 1 lit. a GDPR"),
            "retentionPeriodList" to listOf<String>(),
            "subConsents" to listOf<String>(),
            "language" to "en",
            "linkToDpa" to "",
            "legalGround" to "Art. 6 para. 1 s. 1 lit. c GDPR",
            "optOutUrl" to "",
            "policyOfProcessorUrl" to "https://usercentrics.com/de/datenschutzerklarung/",
            "categorySlug" to "essential",
            "retentionPeriodDescription" to "The consent data (given consent and revocation of consent) are stored for three years. The data will then be deleted immediately or given to the person responsible on request in the form of a data export.",
            "dataProtectionOfficer" to "datenschutz@usercentrics.com",
            "privacyPolicyURL" to "https://usercentrics.com/privacy-policy/",
            "cookiePolicyURL" to "",
            "locationOfProcessing" to "European Union",
            "dataCollectedDescription" to "",
            "thirdCountryTransfer" to "Worldwide",
            "description" to "",
            "isDeactivated" to false,
            "disableLegalBasis" to false,
            "technologyUsed" to listOf("Cookies", "Pixel Tags"),
            "deviceStorage" to listOf(
                mapOf(
                    "identifier" to "identifier",
                    "type" to 2,
                    "name" to "name",
                    "maxAgeSeconds" to 123123L,
                    "cookieRefresh" to true,
                    "purposes" to listOf(1, 2, 3),
                    "domain" to "domain",
                    "description" to "description",
                )
            ),
            "isHidden" to false,
        )
    )

    val fakeAdditionalConsentModeData = AdditionalConsentModeData(
        acString = "2~43.46.55~dv.",
        adTechProviders = listOf(
            AdTechProvider(
                id = 43,
                name = "AdPredictive",
                privacyPolicyUrl = "https://adpredictive.com/privacy",
                consent = false
            ),
            AdTechProvider(
                id = 46,
                name = "Adriver",
                privacyPolicyUrl = "https://www.adriver.ru/about/privacy-en/",
                consent = false
            ),
            AdTechProvider(
                id = 55,
                name = "Adtelligence",
                privacyPolicyUrl = "https://adtelligence.com/en/data-privacy/",
                consent = false
            ),
        )
    )

    val expectedAdditionalConsentModeData = hashMapOf(
        "acString" to "2~43.46.55~dv.",
        "adTechProviders" to listOf(
            mapOf(
                "id" to 43,
                "name" to "AdPredictive",
                "privacyPolicyUrl" to "https://adpredictive.com/privacy",
                "consent" to false
            ),
            mapOf(
                "id" to 46,
                "name" to "Adriver",
                "privacyPolicyUrl" to "https://www.adriver.ru/about/privacy-en/",
                "consent" to false
            ),
            mapOf(
                "id" to 55,
                "name" to "Adtelligence",
                "privacyPolicyUrl" to "https://adtelligence.com/en/data-privacy/",
                "consent" to false
            ),
        )
    )

    val fakeData = mapOf(
        "KeyA" to "ValueA",
        "KeyB" to "ValueB",
    )

    private val expectedData = hashMapOf(
        "KeyA" to "ValueA",
        "KeyB" to "ValueB",
    )

    val fakeLabelsAria = TranslationAriaLabels(
        acceptAllButton = "acceptAllButton",
        ccpaButton = "ccpaButton",
        ccpaMoreInformation = "ccpaMoreInformation",
        closeButton = "closeButton",
        collapse = "collapse",
        cookiePolicyButton = "cookiePolicyButton",
        copyControllerId = "copyControllerId",
        denyAllButton = "denyAllButton",
        expand = "expand",
        fullscreenButton = "fullscreenButton",
        imprintButton = "imprintButton",
        languageSelector = "languageSelector",
        privacyButton = "privacyButton",
        privacyPolicyButton = "privacyPolicyButton",
        saveButton = "saveButton",
        serviceInCategoryDetails = "serviceInCategoryDetails",
        servicesInCategory = "servicesInCategory",
        tabButton = "tabButton",
        usercentricsCMPButtons = "usercentricsCMPButtons",
        usercentricsCMPContent = "usercentricsCMPContent",
        usercentricsCMPHeader = "usercentricsCMPHeader",
        usercentricsCMPUI = "usercentricsCMPUI",
        usercentricsCard = "usercentricsCard",
        usercentricsList = "usercentricsList",
        vendorConsentToggle = "vendorConsentToggle",
        vendorDetailedStorageInformation = "vendorDetailedStorageInformation",
        vendorLegIntToggle = "vendorLegIntToggle"
    )

    val expectedTranslationAriaLabels = hashMapOf(
        "acceptAllButton" to "acceptAllButton",
        "ccpaButton" to "ccpaButton",
        "ccpaMoreInformation" to "ccpaMoreInformation",
        "closeButton" to "closeButton",
        "collapse" to "collapse",
        "cookiePolicyButton" to "cookiePolicyButton",
        "copyControllerId" to "copyControllerId",
        "denyAllButton" to "denyAllButton",
        "expand" to "expand",
        "fullscreenButton" to "fullscreenButton",
        "imprintButton" to "imprintButton",
        "languageSelector" to "languageSelector",
        "privacyButton" to "privacyButton",
        "privacyPolicyButton" to "privacyPolicyButton",
        "saveButton" to "saveButton",
        "serviceInCategoryDetails" to "serviceInCategoryDetails",
        "servicesInCategory" to "servicesInCategory",
        "tabButton" to "tabButton",
        "usercentricsCMPButtons" to "usercentricsCMPButtons",
        "usercentricsCMPContent" to "usercentricsCMPContent",
        "usercentricsCMPHeader" to "usercentricsCMPHeader",
        "usercentricsCMPUI" to "usercentricsCMPUI",
        "usercentricsCard" to "usercentricsCard",
        "usercentricsList" to "usercentricsList",
        "vendorConsentToggle" to "vendorConsentToggle",
        "vendorDetailedStorageInformation" to "vendorDetailedStorageInformation",
        "vendorLegIntToggle" to "vendorLegIntToggle"
    )

    val expectedLegalBasisLocalization = hashMapOf(
        "labelsAria" to expectedTranslationAriaLabels,
        "data" to expectedData,
    )
}
