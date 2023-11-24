export class TCF2Settings {
    firstLayerTitle: string
    secondLayerTitle: string
    tabsPurposeLabel: string
    tabsVendorsLabel: string
    labelsFeatures: string
    labelsIabVendors: string
    labelsNonIabPurposes: string
    labelsNonIabVendors: string
    labelsPurposes: string
    vendorFeatures: string
    vendorLegitimateInterestPurposes: string
    vendorPurpose: string
    vendorSpecialFeatures: string
    vendorSpecialPurposes: string
    togglesConsentToggleLabel: string
    togglesLegIntToggleLabel: string
    buttonsAcceptAllLabel: string
    buttonsDenyAllLabel: string
    buttonsSaveLabel: string
    linksManageSettingsLabel: string
    linksVendorListLinkLabel: string
    cmpId: number
    cmpVersion: number
    firstLayerHideToggles: boolean
    secondLayerHideToggles: boolean
    hideLegitimateInterestToggles: boolean
    firstLayerHideButtonDeny?: boolean
    secondLayerHideButtonDeny: boolean
    publisherCountryCode: string
    purposeOneTreatment: boolean
    selectedVendorIds: [number]
    gdprApplies: boolean
    selectedStacks: [number]
    disabledSpecialFeatures: [number]
    firstLayerShowDescriptions: boolean
    hideNonIabOnFirstLayer: boolean
    resurfacePeriodEnded: boolean
    resurfacePurposeChanged: boolean
    resurfaceVendorAdded: boolean
    firstLayerDescription: string
    firstLayerAdditionalInfo: string
    secondLayerDescription: string
    togglesSpecialFeaturesToggleOn: string
    togglesSpecialFeaturesToggleOff: string
    appLayerNoteResurface: string
    firstLayerNoteResurface: string
    categoriesOfDataLabel: string
    dataRetentionPeriodLabel: string
    legitimateInterestLabel: string
    version: string
    examplesLabel: string
    firstLayerMobileVariant?: FirstLayerMobileVariant
    showDataSharedOutsideEUText: boolean
    dataSharedOutsideEUText?: String
    vendorIdsOutsideEUList: [number]
    scope: TCF2Scope
    changedPurposes: TCF2ChangedPurposes

    constructor(
        firstLayerTitle: string,
        secondLayerTitle: string,
        tabsPurposeLabel: string,
        tabsVendorsLabel: string,
        labelsFeatures: string,
        labelsIabVendors: string,
        labelsNonIabPurposes: string,
        labelsNonIabVendors: string,
        labelsPurposes: string,
        vendorFeatures: string,
        vendorLegitimateInterestPurposes: string,
        vendorPurpose: string,
        vendorSpecialFeatures: string,
        vendorSpecialPurposes: string,
        togglesConsentToggleLabel: string,
        togglesLegIntToggleLabel: string,
        buttonsAcceptAllLabel: string,
        buttonsDenyAllLabel: string,
        buttonsSaveLabel: string,
        linksManageSettingsLabel: string,
        linksVendorListLinkLabel: string,
        cmpId: number,
        cmpVersion: number,
        firstLayerHideToggles: boolean,
        secondLayerHideToggles: boolean,
        hideLegitimateInterestToggles: boolean,
        secondLayerHideButtonDeny: boolean,
        publisherCountryCode: string,
        purposeOneTreatment: boolean,
        selectedVendorIds: [number],
        gdprApplies: boolean,
        selectedStacks: [number],
        disabledSpecialFeatures: [number],
        firstLayerShowDescriptions: boolean,
        hideNonIabOnFirstLayer: boolean,
        resurfacePeriodEnded: boolean,
        resurfacePurposeChanged: boolean,
        resurfaceVendorAdded: boolean,
        firstLayerDescription: string,
        firstLayerAdditionalInfo: string,
        secondLayerDescription: string,
        togglesSpecialFeaturesToggleOn: string,
        togglesSpecialFeaturesToggleOff: string,
        appLayerNoteResurface: string,
        firstLayerNoteResurface: string,
        categoriesOfDataLabel: string,
        dataRetentionPeriodLabel: string,
        legitimateInterestLabel: string,
        version: string,
        examplesLabel: string,
        showDataSharedOutsideEUText: boolean,
        vendorIdsOutsideEUList: [number],
        scope: TCF2Scope,
        changedPurposes: TCF2ChangedPurposes,
        firstLayerHideButtonDeny?: boolean,
        firstLayerMobileVariant?: FirstLayerMobileVariant,
        dataSharedOutsideEUText?: String,
    ) {
        this.firstLayerTitle = firstLayerTitle
        this.secondLayerTitle = secondLayerTitle
        this.tabsPurposeLabel = tabsPurposeLabel
        this.tabsVendorsLabel = tabsVendorsLabel
        this.labelsFeatures = labelsFeatures
        this.labelsIabVendors = labelsIabVendors
        this.labelsNonIabPurposes = labelsNonIabPurposes
        this.labelsNonIabVendors = labelsNonIabVendors
        this.labelsPurposes = labelsPurposes
        this.vendorFeatures = vendorFeatures
        this.vendorLegitimateInterestPurposes = vendorLegitimateInterestPurposes
        this.vendorPurpose = vendorPurpose
        this.vendorSpecialFeatures = vendorSpecialFeatures
        this.vendorSpecialPurposes = vendorSpecialPurposes
        this.togglesConsentToggleLabel = togglesConsentToggleLabel
        this.togglesLegIntToggleLabel = togglesLegIntToggleLabel
        this.buttonsAcceptAllLabel = buttonsAcceptAllLabel
        this.buttonsDenyAllLabel = buttonsDenyAllLabel
        this.buttonsSaveLabel = buttonsSaveLabel
        this.linksManageSettingsLabel = linksManageSettingsLabel
        this.linksVendorListLinkLabel = linksVendorListLinkLabel
        this.cmpId = cmpId
        this.cmpVersion = cmpVersion
        this.firstLayerHideToggles = firstLayerHideToggles
        this.secondLayerHideToggles = secondLayerHideToggles
        this.hideLegitimateInterestToggles = hideLegitimateInterestToggles
        this.firstLayerHideButtonDeny = firstLayerHideButtonDeny
        this.secondLayerHideButtonDeny = secondLayerHideButtonDeny
        this.publisherCountryCode = publisherCountryCode
        this.purposeOneTreatment = purposeOneTreatment
        this.selectedVendorIds = selectedVendorIds
        this.gdprApplies = gdprApplies
        this.selectedStacks = selectedStacks
        this.disabledSpecialFeatures = disabledSpecialFeatures
        this.firstLayerShowDescriptions = firstLayerShowDescriptions
        this.hideNonIabOnFirstLayer = hideNonIabOnFirstLayer
        this.resurfacePeriodEnded = resurfacePeriodEnded
        this.resurfacePurposeChanged = resurfacePurposeChanged
        this.resurfaceVendorAdded = resurfaceVendorAdded
        this.firstLayerDescription = firstLayerDescription
        this.firstLayerAdditionalInfo = firstLayerAdditionalInfo
        this.secondLayerDescription = secondLayerDescription
        this.togglesSpecialFeaturesToggleOn = togglesSpecialFeaturesToggleOn
        this.togglesSpecialFeaturesToggleOff = togglesSpecialFeaturesToggleOff
        this.appLayerNoteResurface = appLayerNoteResurface
        this.firstLayerNoteResurface = firstLayerNoteResurface
        this.categoriesOfDataLabel = categoriesOfDataLabel
        this.dataRetentionPeriodLabel = dataRetentionPeriodLabel
        this.legitimateInterestLabel = legitimateInterestLabel
        this.version = version
        this.examplesLabel = examplesLabel
        this.firstLayerMobileVariant = firstLayerMobileVariant
        this.showDataSharedOutsideEUText = showDataSharedOutsideEUText
        this.dataSharedOutsideEUText = dataSharedOutsideEUText
        this.vendorIdsOutsideEUList = vendorIdsOutsideEUList
        this.scope = scope
        this.changedPurposes = changedPurposes
    }
}

enum FirstLayerMobileVariant { sheet, full, popupBottom, popupCenter }

enum TCF2Scope { global, service }

class TCF2ChangedPurposes {

    purposes: [number]
    legIntPurposes: [number]

    constructor(
        purposes: [number],
        legIntPurposes: [number],
    ) {
        this.purposes = purposes
        this.legIntPurposes = legIntPurposes
    }
}
