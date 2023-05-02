import {CCPASettings} from "./CCPASettings"
import {TCF2Settings} from "./TCF2Settings"
import {UsercentricsLabels} from "./UsercentricsLabels"

export class UsercentricsSettings {
    labels: UsercentricsLabels
    version: string
    language: string
    imprintUrl: string
    privacyPolicyUrl: string
    cookiePolicyUrl: string
    firstLayerDescriptionHtml: string
    firstLayerMobileDescriptionHtml: string
    settingsId: string
    bannerMobileDescriptionIsActive: boolean
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


    constructor(
        labels: UsercentricsLabels,
        version: string,
        language: string,
        imprintUrl: string,
        privacyPolicyUrl: string,
        cookiePolicyUrl: string,
        firstLayerDescriptionHtml: string,
        firstLayerMobileDescriptionHtml: string,
        settingsId: string,
        bannerMobileDescriptionIsActive: boolean,
        enablePoweredBy: boolean,
        displayOnlyForEU: boolean,
        tcf2Enabled: boolean,
        reshowBanner: number,
        editableLanguages: [string],
        languagesAvailable: [string],
        showInitialViewForVersionChange: [string],
        ccpa?: CCPASettings,
        tcf2?: TCF2Settings,
        customization?: string,
        firstLayer?: FirstLayer,
        secondLayer?: SecondLayer
    ) {
        this.labels = labels
        this.version = version
        this.language = language
        this.imprintUrl = imprintUrl
        this.privacyPolicyUrl = privacyPolicyUrl
        this.cookiePolicyUrl = cookiePolicyUrl
        this.firstLayerDescriptionHtml = firstLayerDescriptionHtml
        this.firstLayerMobileDescriptionHtml = firstLayerMobileDescriptionHtml
        this.settingsId = settingsId
        this.bannerMobileDescriptionIsActive = bannerMobileDescriptionIsActive
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
    }

}

class FirstLayer {
    hideButtonDeny?: boolean

    constructor(
        hideButtonDeny?: boolean,
    ) {
        this.hideButtonDeny = hideButtonDeny
    }
}

class SecondLayer {
    tabsCategoriesLabel: string
    tabsServicesLabel: string
    hideButtonDeny?: boolean
    hideLanguageSwitch?: boolean
    acceptButtonText?: string
    denyButtonText?: string

    constructor(
        tabsCategoriesLabel: string,
        tabsServicesLabel: string,
        hideButtonDeny?: boolean,
        hideLanguageSwitch?: boolean,
        acceptButtonText?: string,
        denyButtonText?: string
    ) {
        this.tabsCategoriesLabel = tabsCategoriesLabel
        this.tabsServicesLabel = tabsServicesLabel
        this.hideButtonDeny = hideButtonDeny
        this.hideLanguageSwitch = hideLanguageSwitch
        this.acceptButtonText = acceptButtonText
        this.denyButtonText = denyButtonText
    }

}
