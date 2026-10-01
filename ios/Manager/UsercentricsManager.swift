import Foundation
import Usercentrics
import UsercentricsUI

public protocol UsercentricsManager {
    func configure(options: UsercentricsOptions)

    func isReady(onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void))
    func restoreUserSession(controllerId: String, onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void))

    func showFirstLayer(bannerSettings: BannerSettings?,
                        onLoginClicked: @escaping (String?) -> Void,
                        onSubscribeClicked: @escaping (String?) -> Void,
                        dismissViewHandler: @escaping (UsercentricsConsentUserResponse) -> Void)

    func notifyLoginSuccess(onSuccess: @escaping (() -> Void), onError: @escaping ((Error) -> Void))
    func notifySubscribeSuccess(onSuccess: @escaping (() -> Void), onError: @escaping ((Error) -> Void))
    func notifySubscriptionLapsed(onSuccess: @escaping (() -> Void), onError: @escaping ((Error) -> Void))

    func showSecondLayer(bannerSettings: BannerSettings?,
                         dismissViewHandler: @escaping (UsercentricsConsentUserResponse) -> Void)

    func getControllerId() -> String
    func getConsents() -> [UsercentricsServiceConsent]
    func getCMPData() -> UsercentricsCMPData
    func getUserSessionData() -> String
    func getUSPData() -> CCPAData
    func getGPPData() -> GppData
    func getGPPString() -> String?
    func setGPPConsent(sectionName: String, fieldName: String, value: Any)
    func getTCFData(callback: @escaping (TCFData) -> Void)
    func getABTestingVariant() -> String?
    func getDpsMetadata(templateId: String) -> [String: Any]?
    func getAdditionalConsentModeData() -> AdditionalConsentModeData
    func onGppSectionChange(callback: @escaping (GppSectionChangePayload) -> Void) -> UsercentricsDisposableEvent<GppSectionChangePayload>

    func changeLanguage(language: String, onSuccess: @escaping (() -> Void), onFailure: @escaping ((Error) -> Void))

    func acceptAllForTCF(fromLayer: TCFDecisionUILayer, consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent]
    func acceptAll(consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent]

    func denyAllForTCF(fromLayer: TCFDecisionUILayer, consentType: UsercentricsConsentType, unsavedPurposeLIDecisions: [KotlinInt: KotlinBoolean]?, unsavedVendorLIDecisions: [KotlinInt: KotlinBoolean]?, unsavedServiceDecisions: [String: KotlinBoolean]?) -> [UsercentricsServiceConsent]
    func denyAll(consentType: UsercentricsConsentType, unsavedServiceDecisions: [String: KotlinBoolean]?) -> [UsercentricsServiceConsent]

    func saveDecisionsForTCF(tcfDecisions: TCFUserDecisions,
                             fromLayer: TCFDecisionUILayer,
                             serviceDecisions: [UserDecision],
                             consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent]
    func saveDecisions(decisions: [UserDecision], consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent]
    func saveOptOutForCCPA(isOptedOut: Bool, consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent]
    func setCMPId(id: Int32)
    func setABTestingVariant(variant: String)
    func track(event: UsercentricsAnalyticsEventType)

    func clearUserSession(onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onError: @escaping ((Error) -> Void))
}

final class UsercentricsManagerImplementation: UsercentricsManager {

    func isReady(onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void)) {
        UsercentricsCore.isReady(onSuccess: onSuccess, onFailure: onFailure)
    }

    func configure(options: UsercentricsOptions) {
        UsercentricsCore.configure(options: options)
    }

    func showFirstLayer(bannerSettings: BannerSettings?,
                        onLoginClicked: @escaping (String?) -> Void,
                        onSubscribeClicked: @escaping (String?) -> Void,
                        dismissViewHandler: @escaping (UsercentricsConsentUserResponse) -> Void) {
        UsercentricsBanner(bannerSettings: bannerSettings).showFirstLayer(onLoginClicked: onLoginClicked,
                                                                          onSubscribeClicked: onSubscribeClicked,
                                                                          completionHandler: dismissViewHandler)
    }

    func notifyLoginSuccess(onSuccess: @escaping (() -> Void), onError: @escaping ((Error) -> Void)) {
        UsercentricsCore.shared.notifyLoginSuccess(onSuccess: onSuccess, onError: onError)
    }

    func notifySubscribeSuccess(onSuccess: @escaping (() -> Void), onError: @escaping ((Error) -> Void)) {
        UsercentricsCore.shared.notifySubscribeSuccess(onSuccess: onSuccess, onError: onError)
    }

    func notifySubscriptionLapsed(onSuccess: @escaping (() -> Void), onError: @escaping ((Error) -> Void)) {
        UsercentricsCore.shared.notifySubscriptionLapsed(onSuccess: onSuccess, onError: onError)
    }

    func showSecondLayer(bannerSettings: BannerSettings?,
                         dismissViewHandler: @escaping (UsercentricsConsentUserResponse) -> Void) {
        UsercentricsBanner(bannerSettings: bannerSettings).showSecondLayer(completionHandler: dismissViewHandler)
    }

    func restoreUserSession(controllerId: String, onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void)) {
        UsercentricsCore.shared.restoreUserSession(controllerId: controllerId, onSuccess: onSuccess, onFailure: onFailure)
    }

    func getControllerId() -> String {
        return UsercentricsCore.shared.getControllerId()
    }

    func getABTestingVariant() -> String? {
        return UsercentricsCore.shared.getABTestingVariant()
    }

    func getConsents() -> [UsercentricsServiceConsent] {
        return UsercentricsCore.shared.getConsents()
    }

    func getCMPData() -> UsercentricsCMPData {
        return UsercentricsCore.shared.getCMPData()
    }

    func getUserSessionData() -> String {
        return UsercentricsCore.shared.getUserSessionData()
    }

    func getUSPData() -> CCPAData {
        return UsercentricsCore.shared.getUSPData()
    }

    func getGPPData() -> GppData {
        return UsercentricsCore.shared.getGPPData()
    }

    func getGPPString() -> String? {
        return UsercentricsCore.shared.getGPPString()
    }

    func setGPPConsent(sectionName: String, fieldName: String, value: Any) {
        UsercentricsCore.shared.setGPPConsent(sectionName: sectionName, fieldName: fieldName, value: value)
    }

    func onGppSectionChange(callback: @escaping (GppSectionChangePayload) -> Void) -> UsercentricsDisposableEvent<GppSectionChangePayload> {
        return UsercentricsEvent.shared.onGppSectionChange(callback: callback)
    }

    func getTCFData(callback: @escaping (TCFData) -> Void) {
        UsercentricsCore.shared.getTCFData(callback: callback)
    }

    func getDpsMetadata(templateId: String) -> [String: Any]? {
        return UsercentricsCore.shared.getDpsMetadata(templateId: templateId)
    }

    func getAdditionalConsentModeData() -> AdditionalConsentModeData {
        return UsercentricsCore.shared.getAdditionalConsentModeData()
    }

    func changeLanguage(language: String, onSuccess: @escaping (() -> Void), onFailure: @escaping ((Error) -> Void)) {
        UsercentricsCore.shared.changeLanguage(language: language, onSuccess: onSuccess, onFailure: onFailure)
    }

    func acceptAllForTCF(fromLayer: TCFDecisionUILayer, consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent] {
        return UsercentricsCore.shared.acceptAllForTCF(fromLayer: fromLayer, consentType: consentType)
    }

    func acceptAll(consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent] {
        return UsercentricsCore.shared.acceptAll(consentType: consentType)
    }

    func denyAllForTCF(fromLayer: TCFDecisionUILayer, consentType: UsercentricsConsentType, unsavedPurposeLIDecisions: [KotlinInt: KotlinBoolean]?, unsavedVendorLIDecisions: [KotlinInt: KotlinBoolean]?, unsavedServiceDecisions: [String: KotlinBoolean]?) -> [UsercentricsServiceConsent] {
        return UsercentricsCore.shared.denyAllForTCF(fromLayer: fromLayer, consentType: consentType, unsavedPurposeLIDecisions: unsavedPurposeLIDecisions, unsavedVendorLIDecisions: unsavedVendorLIDecisions, unsavedServiceDecisions: unsavedServiceDecisions)
    }

    func denyAll(consentType: UsercentricsConsentType, unsavedServiceDecisions: [String: KotlinBoolean]?) -> [UsercentricsServiceConsent] {
        return UsercentricsCore.shared.denyAll(consentType: consentType, unsavedServiceDecisions: unsavedServiceDecisions)
    }

    func saveDecisionsForTCF(tcfDecisions: TCFUserDecisions, fromLayer: TCFDecisionUILayer, serviceDecisions: [UserDecision], consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent] {
        return UsercentricsCore.shared.saveDecisionsForTCF(tcfDecisions: tcfDecisions, fromLayer: fromLayer, serviceDecisions: serviceDecisions, consentType: consentType)
    }

    func saveDecisions(decisions: [UserDecision], consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent] {
        return UsercentricsCore.shared.saveDecisions(decisions: decisions, consentType: consentType)
    }

    func saveOptOutForCCPA(isOptedOut: Bool, consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent] {
        return UsercentricsCore.shared.saveOptOutForCCPA(isOptedOut: isOptedOut, consentType: consentType)
    }

    func setCMPId(id: Int32) {
        UsercentricsCore.shared.setCMPId(id: id)
    }

    func setABTestingVariant(variant: String) {
        UsercentricsCore.shared.setABTestingVariant(variantName: variant)
    }

    func track(event: UsercentricsAnalyticsEventType) {
        UsercentricsCore.shared.track(event: event)
    }
    
    func clearUserSession(onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onError: @escaping ((Error) -> Void)) {
        UsercentricsCore.shared.clearUserSession(onSuccess: onSuccess, onError: onError)
    }
}
