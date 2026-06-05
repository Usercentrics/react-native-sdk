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
    resurfacePeriod: number
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
    dataSharedOutsideEUText?: string
    vendorIdsOutsideEUList: [number]
    scope: TCF2Scope
    changedPurposes: TCF2ChangedPurposes
    acmV2Enabled: boolean
    selectedATPIds: number[]
    consentOrPay?: TCF2ConsentOrPaySettings
    mandatoryLabel: string
    specialFeaturesConsentOrPay?: ConsentOrPayRestriction[]

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
        resurfacePeriod: number,
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
        acmV2Enabled: boolean,
        selectedATPIds: number[],
        firstLayerHideButtonDeny?: boolean,
        firstLayerMobileVariant?: FirstLayerMobileVariant,
        dataSharedOutsideEUText?: string,
        consentOrPay?: TCF2ConsentOrPaySettings,
        mandatoryLabel: string = 'Mandatory',
        specialFeaturesConsentOrPay?: ConsentOrPayRestriction[],
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
        this.resurfacePeriod = resurfacePeriod
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
        this.acmV2Enabled = acmV2Enabled
        this.selectedATPIds = selectedATPIds
        this.consentOrPay = consentOrPay
        this.mandatoryLabel = mandatoryLabel
        this.specialFeaturesConsentOrPay = specialFeaturesConsentOrPay
    }
}

export enum FirstLayerMobileVariant {
    sheet = 0,
    full = 1,
    popupBottom = 2,
    popupCenter = 3
}

export enum TCF2Scope {
    global = 0,
    service = 1
}

export class TCF2ChangedPurposes {

    purposes: [number]
    legIntPurposes: [number]
    consentOrPay?: ConsentOrPayRestriction[]

    constructor(
        purposes: [number],
        legIntPurposes: [number],
        consentOrPay?: ConsentOrPayRestriction[],
    ) {
        this.purposes = purposes
        this.legIntPurposes = legIntPurposes
        this.consentOrPay = consentOrPay
    }
}

export class ConsentOrPayRestriction {
    id: number
    value: string

    constructor(id: number, value: string) {
        this.id = id
        this.value = value
    }

    isFlexible(): boolean {
        return this.value?.toUpperCase() === 'FLEXIBLE'
    }
}

export class TCF2ConsentOrPaySettings {

    enableConsentOrPay: boolean
    showTogglesForVendors: boolean
    /** Maps TCF Purpose ID (as string) to "flexible". Absent entries are mandatory. */
    publisherRestrictions: Record<string, string>
    /** Maps Special Feature ID (as string) to "flexible". Absent entries are mandatory. */
    specialFeatures: Record<string, string>

    constructor(
        enableConsentOrPay: boolean,
        showTogglesForVendors: boolean,
        publisherRestrictions: Record<string, string>,
        specialFeatures: Record<string, string>,
    ) {
        this.enableConsentOrPay = enableConsentOrPay
        this.showTogglesForVendors = showTogglesForVendors
        this.publisherRestrictions = publisherRestrictions
        this.specialFeatures = specialFeatures
    }
}
