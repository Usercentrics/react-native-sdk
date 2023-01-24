export class CCPASettings { 
    optOutNoticeLabel: string
    btnSave: string
    firstLayerTitle: string
    isActive: boolean
    showOnPageLoad: boolean
    reshowAfterDays: number
    iabAgreementExists: boolean
    appFirstLayerDescription: string
    firstLayerMobileDescriptionIsActive: boolean
    firstLayerMobileDescription: string
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
    reshowAfterDays: number, 
    iabAgreementExists: boolean, 
    appFirstLayerDescription: string, 
    firstLayerMobileDescriptionIsActive: boolean, 
    firstLayerMobileDescription: string, 
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
    this.reshowAfterDays = reshowAfterDays
    this.iabAgreementExists = iabAgreementExists
    this.appFirstLayerDescription = appFirstLayerDescription
    this.firstLayerMobileDescriptionIsActive = firstLayerMobileDescriptionIsActive
    this.firstLayerMobileDescription = firstLayerMobileDescription
    this.secondLayerTitle = secondLayerTitle
    this.secondLayerDescription = secondLayerDescription
    this.secondLayerHideLanguageSwitch = secondLayerHideLanguageSwitch
    this.btnMoreInfo = btnMoreInfo
  }
    
}