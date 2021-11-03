export class CCPASettings { 
    optOutNoticeLabel: string
    btnSave: string
    firstLayerTitle: string
    isActive: boolean
    showOnPageLoad: boolean
    reshowCMP: boolean
    reshowAfterDays: number
    iabAgreementExists: boolean
    firstLayerDescription: string
    appFirstLayerDescription: string
    firstLayerMobileDescriptionIsActive: boolean
    firstLayerMobileDescription: string
    firstLayerHideLanguageSwitch: boolean
    secondLayerTitle: string
    secondLayerDescription: string
    secondLayerHideLanguageSwitch: boolean
    btnMoreInfo: string

  constructor(
    optOutNoticeLabel: string, 
    btnSave: string, 
    firstLayerTitle: string, 
    isActive: boolean, 
    showOnPageLoad: boolean, 
    reshowCMP: boolean, 
    reshowAfterDays: number, 
    iabAgreementExists: boolean, 
    firstLayerDescription: string, 
    appFirstLayerDescription: string, 
    firstLayerMobileDescriptionIsActive: boolean, 
    firstLayerMobileDescription: string, 
    firstLayerHideLanguageSwitch: boolean, 
    secondLayerTitle: string, 
    secondLayerDescription: string, 
    secondLayerHideLanguageSwitch: boolean, 
    btnMoreInfo: string
) {
    this.optOutNoticeLabel = optOutNoticeLabel
    this.btnSave = btnSave
    this.firstLayerTitle = firstLayerTitle
    this.isActive = isActive
    this.showOnPageLoad = showOnPageLoad
    this.reshowCMP = reshowCMP
    this.reshowAfterDays = reshowAfterDays
    this.iabAgreementExists = iabAgreementExists
    this.firstLayerDescription = firstLayerDescription
    this.appFirstLayerDescription = appFirstLayerDescription
    this.firstLayerMobileDescriptionIsActive = firstLayerMobileDescriptionIsActive
    this.firstLayerMobileDescription = firstLayerMobileDescription
    this.firstLayerHideLanguageSwitch = firstLayerHideLanguageSwitch
    this.secondLayerTitle = secondLayerTitle
    this.secondLayerDescription = secondLayerDescription
    this.secondLayerHideLanguageSwitch = secondLayerHideLanguageSwitch
    this.btnMoreInfo = btnMoreInfo
  }
    
}