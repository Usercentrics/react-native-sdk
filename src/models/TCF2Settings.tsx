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
    consensuDomain: string
    consensuScriptPath: string
    selectedStacks: [number]
    disabledSpecialFeatures: [number]
    firstLayerShowDescriptions: boolean
    hideNonIabOnFirstLayer: boolean
    resurfaceIABLegalBasisChanged: boolean
    resurfacePeriodEnded: boolean
    resurfacePurposeChanged: boolean
    resurfaceVendorAdded: boolean
    vendorToggleAll: boolean
    firstLayerDescription: string
    firstLayerAdditionalInfo: string
    secondLayerDescription: string
    togglesSpecialFeaturesToggleOn: string
    togglesSpecialFeaturesToggleOff: string
    appLayerNoteResurface: string
    firstLayerNoteGlobal: string
    firstLayerNoteResurface: string


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
    consensuDomain: string, 
    consensuScriptPath: string, 
    selectedStacks: [number], 
    disabledSpecialFeatures: [number], 
    firstLayerShowDescriptions: boolean, 
    hideNonIabOnFirstLayer: boolean, 
    resurfaceIABLegalBasisChanged: boolean, 
    resurfacePeriodEnded: boolean, 
    resurfacePurposeChanged: boolean, 
    resurfaceVendorAdded: boolean, 
    vendorToggleAll: boolean, 
    firstLayerDescription: string, 
    firstLayerAdditionalInfo: string, 
    secondLayerDescription: string, 
    togglesSpecialFeaturesToggleOn: string, 
    togglesSpecialFeaturesToggleOff: string, 
    appLayerNoteResurface: string, 
    firstLayerNoteGlobal: string, 
    firstLayerNoteResurface: string,
    firstLayerHideButtonDeny?: boolean, 
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
    this.consensuDomain = consensuDomain
    this.consensuScriptPath = consensuScriptPath
    this.selectedStacks = selectedStacks
    this.disabledSpecialFeatures = disabledSpecialFeatures
    this.firstLayerShowDescriptions = firstLayerShowDescriptions
    this.hideNonIabOnFirstLayer = hideNonIabOnFirstLayer
    this.resurfaceIABLegalBasisChanged = resurfaceIABLegalBasisChanged
    this.resurfacePeriodEnded = resurfacePeriodEnded
    this.resurfacePurposeChanged = resurfacePurposeChanged
    this.resurfaceVendorAdded = resurfaceVendorAdded
    this.vendorToggleAll = vendorToggleAll
    this.firstLayerDescription = firstLayerDescription
    this.firstLayerAdditionalInfo = firstLayerAdditionalInfo
    this.secondLayerDescription = secondLayerDescription
    this.togglesSpecialFeaturesToggleOn = togglesSpecialFeaturesToggleOn
    this.togglesSpecialFeaturesToggleOff = togglesSpecialFeaturesToggleOff
    this.appLayerNoteResurface = appLayerNoteResurface
    this.firstLayerNoteGlobal = firstLayerNoteGlobal
    this.firstLayerNoteResurface = firstLayerNoteResurface
  }

}