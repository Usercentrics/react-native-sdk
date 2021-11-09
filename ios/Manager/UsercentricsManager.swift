import Foundation
import Usercentrics
import UsercentricsUI
import RxSwift

public protocol UsercentricsManager {
    var alreadyConfigured: Bool { get }
    func configure(options: UsercentricsOptions)

    func isReady(onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void))
    func restoreUserSession(controllerId: String, onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void))

    func getPredefinedUI(settings: UsercentricsUISettings?, dismissViewHandler: @escaping (UsercentricsConsentUserResponse) -> Void) -> UIViewController
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

    private let isConfiguredBeforeKey: String = "usercentrics.isConfiguredBefore"

    var isConfigured: Bool = false
    private var bag: DisposeBag = DisposeBag()

    private let isConfiguredObservable: BehaviorSubject<Bool>
    var alreadyConfigured: Bool {
        try! isConfiguredObservable.value()
    }

    init() {
        let isConfiguredBefore = UserDefaults.standard.bool(forKey: self.isConfiguredBeforeKey)
        isConfiguredObservable = .init(value: isConfiguredBefore)

        setupActions()
    }

    private func setupActions() {
        isConfiguredObservable
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                UserDefaults.standard.set($0, forKey: self.isConfiguredBeforeKey)
            }).disposed(by: bag)
    }

    func isReady(onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void)) {
        var subscription: Disposable?

        subscription = isConfiguredObservable
            .subscribe(onNext: { isConfigured in
                guard isConfigured else { return }
                UsercentricsCore.isReady(onSuccess: onSuccess, onFailure: onFailure)
                subscription?.dispose()
            })

        subscription?.disposed(by: bag)
    }

    func configure(options: UsercentricsOptions) {
        UsercentricsCore.configure(options: options)
        isConfiguredObservable.onNext(true)
    }

    func reset() {
        UsercentricsCore.reset()
        isConfiguredObservable.onNext(false)
    }

    func getPredefinedUI(settings: UsercentricsUISettings?, dismissViewHandler: @escaping (UsercentricsConsentUserResponse) -> Void) -> UIViewController {
        return UsercentricsUserInterface.getPredefinedUI(settings: settings, dismissViewHandler: dismissViewHandler)
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
