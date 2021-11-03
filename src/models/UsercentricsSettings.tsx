import { CCPASettings } from "./CCPASettings"
import { TCF2Settings } from "./TCF2Settings"
import { UsercentricsLabels } from "./UsercentricsLabels"

export class UsercentricsSettings {
    labels: UsercentricsLabels
    version: string
    urlConsentInfo: string 
    language: string 
    partnerPoweredByUrl: string
    partnerPoweredByLogoUrl: string
    imprintUrl: string
    privacyPolicyUrl: string
    cookiePolicyUrl: string
    bannerMessage: string
    bannerMobileDescription: string
    dataController: string
    createdAt: string
    updatedAt: string
    settingsId: string
    isLatest?: boolean
    btnMoreInfoIsVisible: boolean
    btnDenyIsVisible: boolean
    showLanguageDropdown: boolean
    bannerMobileDescriptionIsActive: boolean
    iabConsentIsActive: boolean
    enablePoweredBy: boolean
    displayOnlyForEU: boolean
    tcf2Enabled: boolean
    reshowBanner: number
    editableLanguages: [string]
    languagesAvailable: [string]
    showInitialViewForVersionChange: [string]
    ccpa?: CCPASettings
    tcf2?: TCF2Settings
    customization?: string
    firstLayer?: FirstLayer
    secondLayer?: SecondLayer
    moreInfoButtonUrl: string


  constructor(
    labels: UsercentricsLabels, 
    version: string, 
    urlConsentInfo: string , 
    language: string , 
    partnerPoweredByUrl: string, 
    partnerPoweredByLogoUrl: string, 
    imprintUrl: string, 
    privacyPolicyUrl: string, 
    cookiePolicyUrl: string, 
    bannerMessage: string, 
    bannerMobileDescription: string, 
    dataController: string, 
    createdAt: string, 
    updatedAt: string, 
    settingsId: string, 
    btnMoreInfoIsVisible: boolean, 
    btnDenyIsVisible: boolean, 
    showLanguageDropdown: boolean, 
    bannerMobileDescriptionIsActive: boolean, 
    iabConsentIsActive: boolean, 
    enablePoweredBy: boolean, 
    displayOnlyForEU: boolean, 
    tcf2Enabled: boolean, 
    reshowBanner: number, 
    editableLanguages: [string], 
    languagesAvailable: [string], 
    showInitialViewForVersionChange: [string], 
    moreInfoButtonUrl: string,
    isLatest?: boolean, 
    ccpa?: CCPASettings, 
    tcf2?: TCF2Settings, 
    customization?: string, 
    firstLayer?: FirstLayer, 
    secondLayer?: SecondLayer
) {
    this.labels = labels
    this.version = version
    this.urlConsentInfo = urlConsentInfo
    this.language = language
    this.partnerPoweredByUrl = partnerPoweredByUrl
    this.partnerPoweredByLogoUrl = partnerPoweredByLogoUrl
    this.imprintUrl = imprintUrl
    this.privacyPolicyUrl = privacyPolicyUrl
    this.cookiePolicyUrl = cookiePolicyUrl
    this.bannerMessage = bannerMessage
    this.bannerMobileDescription = bannerMobileDescription
    this.dataController = dataController
    this.createdAt = createdAt
    this.updatedAt = updatedAt
    this.settingsId = settingsId
    this.isLatest = isLatest
    this.btnMoreInfoIsVisible = btnMoreInfoIsVisible
    this.btnDenyIsVisible = btnDenyIsVisible
    this.showLanguageDropdown = showLanguageDropdown
    this.bannerMobileDescriptionIsActive = bannerMobileDescriptionIsActive
    this.iabConsentIsActive = iabConsentIsActive
    this.enablePoweredBy = enablePoweredBy
    this.displayOnlyForEU = displayOnlyForEU
    this.tcf2Enabled = tcf2Enabled
    this.reshowBanner = reshowBanner
    this.editableLanguages = editableLanguages
    this.languagesAvailable = languagesAvailable
    this.showInitialViewForVersionChange = showInitialViewForVersionChange
    this.ccpa = ccpa
    this.tcf2 = tcf2
    this.customization = customization
    this.firstLayer = firstLayer
    this.secondLayer = secondLayer
    this.moreInfoButtonUrl = moreInfoButtonUrl
  }
    
}

class FirstLayer { 
    isOverlayEnabled?: boolean
    isCategoryTogglesEnabled?: boolean
    hideButtonDeny?: boolean
    hideLanguageSwitch?: boolean
    title: string
    descriptionDefault: string
    descriptionShort: string


  constructor(
    title: string, 
    descriptionDefault: string, 
    descriptionShort: string,
    isOverlayEnabled?: boolean, 
    isCategoryTogglesEnabled?: boolean, 
    hideButtonDeny?: boolean, 
    hideLanguageSwitch?: boolean
) {
    this.isOverlayEnabled = isOverlayEnabled
    this.isCategoryTogglesEnabled = isCategoryTogglesEnabled
    this.hideButtonDeny = hideButtonDeny
    this.hideLanguageSwitch = hideLanguageSwitch
    this.title = title
    this.descriptionDefault = descriptionDefault
    this.descriptionShort = descriptionShort
  }
}

class SecondLayer { 
    tabsCategoriesLabel: string
    tabsServicesLabel: string
    isOverlayEnabled?: boolean
    tabsCategoriesIsEnabled?: boolean
    tabsServicesIsEnabled?: boolean
    hideButtonDeny?: boolean
    hideLanguageSwitch?: boolean
    title: string
    description: string


  constructor(
    tabsCategoriesLabel: string, 
    tabsServicesLabel: string, 
    title: string, 
    description: string,
    isOverlayEnabled?: boolean, 
    tabsCategoriesIsEnabled?: boolean, 
    tabsServicesIsEnabled?: boolean, 
    hideButtonDeny?: boolean, 
    hideLanguageSwitch?: boolean
) {
    this.tabsCategoriesLabel = tabsCategoriesLabel
    this.tabsServicesLabel = tabsServicesLabel
    this.isOverlayEnabled = isOverlayEnabled
    this.tabsCategoriesIsEnabled = tabsCategoriesIsEnabled
    this.tabsServicesIsEnabled = tabsServicesIsEnabled
    this.hideButtonDeny = hideButtonDeny
    this.hideLanguageSwitch = hideLanguageSwitch
    this.title = title
    this.description = description
  }
    
}