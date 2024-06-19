export class LegalBasisLocalization {
    labelsAria?: TranslationAriaLabels
    data: Map<string, string>

    constructor(
        data: Map<string, string>,
        labelsAria?: TranslationAriaLabels
    ) {
        this.data = data
        this.labelsAria = labelsAria
    }
}

export class TranslationAriaLabels {
    acceptAllButton?: string
    ccpaButton?: string
    ccpaMoreInformation?: string
    closeButton?: string
    collapse?: string
    cookiePolicyButton?: string
    copyControllerId?: string
    denyAllButton?: string
    expand?: string
    fullscreenButton?: string
    imprintButton?: string
    languageSelector?: string
    privacyButton?: string
    privacyPolicyButton?: string
    saveButton?: string
    serviceInCategoryDetails?: string
    servicesInCategory?: string
    tabButton?: string
    usercentricsCMPButtons?: string
    usercentricsCMPContent?: string
    usercentricsCMPHeader?: string
    usercentricsCMPUI?: string
    usercentricsCard?: string
    usercentricsList?: string
    vendorConsentToggle?: string
    vendorDetailedStorageInformation?: string
    vendorLegIntToggle?: string

    constructor(
        acceptAllButton?: string,
        ccpaButton?: string,
        ccpaMoreInformation?: string,
        closeButton?: string,
        collapse?: string,
        cookiePolicyButton?: string,
        copyControllerId?: string,
        denyAllButton?: string,
        expand?: string,
        fullscreenButton?: string,
        imprintButton?: string,
        languageSelector?: string,
        privacyButton?: string,
        privacyPolicyButton?: string,
        saveButton?: string,
        serviceInCategoryDetails?: string,
        servicesInCategory?: string,
        tabButton?: string,
        usercentricsCMPButtons?: string,
        usercentricsCMPContent?: string,
        usercentricsCMPHeader?: string,
        usercentricsCMPUI?: string,
        usercentricsCard?: string,
        usercentricsList?: string,
        vendorConsentToggle?: string,
        vendorDetailedStorageInformation?: string,
        vendorLegIntToggle?: string
    ) {
        this.acceptAllButton = acceptAllButton
        this.ccpaButton = ccpaButton
        this.ccpaMoreInformation = ccpaMoreInformation;
        this.closeButton = closeButton
        this.collapse = collapse
        this.cookiePolicyButton = cookiePolicyButton
        this.copyControllerId = copyControllerId
        this.denyAllButton = denyAllButton
        this.expand = expand
        this.fullscreenButton = fullscreenButton
        this.imprintButton = imprintButton
        this.languageSelector = languageSelector
        this.privacyButton = privacyButton
        this.privacyPolicyButton = privacyPolicyButton
        this.saveButton = saveButton
        this.serviceInCategoryDetails = serviceInCategoryDetails
        this.servicesInCategory = servicesInCategory
        this.tabButton = tabButton
        this.usercentricsCMPButtons = usercentricsCMPButtons
        this.usercentricsCMPContent = usercentricsCMPContent
        this.usercentricsCMPHeader = usercentricsCMPHeader
        this.usercentricsCMPUI = usercentricsCMPUI
        this.usercentricsCard = usercentricsCard
        this.usercentricsList = usercentricsList
        this.vendorConsentToggle = vendorConsentToggle
        this.vendorDetailedStorageInformation = vendorDetailedStorageInformation
        this.vendorLegIntToggle = vendorLegIntToggle
    }
}
