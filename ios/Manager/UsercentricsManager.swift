import Foundation
import Usercentrics
import UsercentricsUI

public protocol UsercentricsManager {
    func configure(options: UsercentricsOptions)

    func isReady(onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void))
    func restoreUserSession(controllerId: String, onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void))

    func showFirstLayer(bannerSettings: BannerSettings?,
                        hostView: UIViewController,
                        layout: UsercentricsLayout,
                        settings: FirstLayerStyleSettings?,
                        dismissViewHandler: @escaping (UsercentricsConsentUserResponse) -> Void)

    func showSecondLayer(bannerSettings: BannerSettings?,
                         hostView: UIViewController,
                         showCloseButton: Bool,
                         dismissViewHandler: @escaping (UsercentricsConsentUserResponse) -> Void)

    func getTCString() -> String
    func getControllerId() -> String
    func getConsents() -> [UsercentricsServiceConsent]
    func getCMPData() -> UsercentricsCMPData
    func getUserSessionData() -> String
    func getUSPData() -> CCPAData
    func getTCFData() -> TCFData

    func changeLanguage(language: String, onSuccess: @escaping (() -> Void), onFailure: @escaping ((Error) -> Void))

    func acceptAllForTCF(fromLayer: TCFDecisionUILayer, consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent]
    func acceptAll(consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent]

    func denyAllForTCF(fromLayer: TCFDecisionUILayer, consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent]
    func denyAll(consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent]

    func saveDecisionsForTCF(tcfDecisions: TCFUserDecisions,
                             fromLayer: TCFDecisionUILayer,
                             serviceDecisions: [UserDecision],
                             consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent]
    func saveDecisions(decisions: [UserDecision], consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent]
    func saveOptOutForCCPA(isOptedOut: Bool, consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent]
    func setCMPId(id: Int32)

    func reset()
}

final class UsercentricsManagerImplementation: UsercentricsManager {

    func isReady(onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void)) {
        UsercentricsCore.isReady(onSuccess: onSuccess, onFailure: onFailure)
    }

    func configure(options: UsercentricsOptions) {
        var isConfigured: Bool = false
        isReady { _ in
            isConfigured = true
        } onFailure: { _ in
            isConfigured = true
        }

        guard !isConfigured else { return }
        
        UsercentricsCore.configure(options: options)
    }

    func reset() {
        UsercentricsCore.reset()
    }

    func showFirstLayer(bannerSettings: BannerSettings?,
                        hostView: UIViewController,
                        layout: UsercentricsLayout,
                        settings: FirstLayerStyleSettings?,
                        dismissViewHandler: @escaping (UsercentricsConsentUserResponse) -> Void) {
        UsercentricsBanner(bannerSettings: bannerSettings).showFirstLayer(hostView: hostView,
                                                                          layout: layout,
                                                                          settings: settings,
                                                                          completionHandler: dismissViewHandler)
    }

    func showSecondLayer(bannerSettings: BannerSettings?,
                         hostView: UIViewController,
                         showCloseButton: Bool,
                         dismissViewHandler: @escaping (UsercentricsConsentUserResponse) -> Void) {
        UsercentricsBanner(bannerSettings: bannerSettings).showSecondLayer(hostView: hostView,
                                                                           showCloseButton: showCloseButton,
                                                                           completionHandler: dismissViewHandler)
    }

    func restoreUserSession(controllerId: String, onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void)) {
        UsercentricsCore.shared.restoreUserSession(controllerId: controllerId, onSuccess: onSuccess, onFailure: onFailure)
    }

    func getTCString() -> String {
        return UsercentricsCore.shared.getTCString()
    }

    func getControllerId() -> String {
        return UsercentricsCore.shared.getControllerId()
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

    func getTCFData() -> TCFData {
        return UsercentricsCore.shared.getTCFData()
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

    func denyAllForTCF(fromLayer: TCFDecisionUILayer, consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent] {
        return UsercentricsCore.shared.denyAllForTCF(fromLayer: fromLayer, consentType: consentType)
    }

    func denyAll(consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent] {
        return UsercentricsCore.shared.denyAll(consentType: consentType)
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
}
