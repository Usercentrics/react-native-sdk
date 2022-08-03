
import Foundation
import react_native_usercentrics
import Usercentrics
import UsercentricsUI
import UIKit

enum FakeUsercentricsError: Error {
  case test
}

final class FakeUsercentricsManager: UsercentricsManager {

  var alreadyConfigured: Bool = false

  var restoreControllerId: String?

  var getTCStringValue: String?
  var getControllerIdValue: String?

  var configureOptions: UsercentricsOptions?
  var isReadySuccessCompletion: UsercentricsReadyStatus?
  var isReadyErrorCompletion: Error?

  var restoreUserSessionSuccess: UsercentricsReadyStatus?
  var restoreUserSessionError: Error?

  var resetCount: Int = 0

  func isReady(onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void)) {
    if let isReadySuccessCompletion = isReadySuccessCompletion {
      onSuccess(isReadySuccessCompletion)
    }

    if let isReadyErrorCompletion = isReadyErrorCompletion {
      onFailure(isReadyErrorCompletion)
    }
  }

  func configure(options: UsercentricsOptions) {
    self.configureOptions = options
    alreadyConfigured = true
  }

  func reset() {
    resetCount += 1
    alreadyConfigured = false
  }

  func restoreUserSession(controllerId: String, onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void)) {
    self.restoreControllerId = controllerId
    
    if let restoreUserSessionSuccess = restoreUserSessionSuccess {
      onSuccess(restoreUserSessionSuccess)
    }

    if let restoreUserSessionError = restoreUserSessionError {
      onFailure(restoreUserSessionError)
    }
  }

  func getTCString(callback: @escaping (String) -> Void) {
    callback(getTCStringValue!)
  }

  func getControllerId() -> String {
    return getControllerIdValue!
  }

  var getConsentsResponse: [UsercentricsServiceConsent]?
  func getConsents() -> [UsercentricsServiceConsent] {
    return getConsentsResponse!
  }

  var getCMPDataResponse: UsercentricsCMPData?
  func getCMPData() -> UsercentricsCMPData {
    return getCMPDataResponse!
  }

  var getUserSessionDataResponse: String?
  func getUserSessionData() -> String {
    return getUserSessionDataResponse!
  }

  var getUSPDataResponse: CCPAData?
  func getUSPData() -> CCPAData {
    return getUSPDataResponse!
  }

  var getTCFDataResponse: TCFData?
  func getTCFData(callback: @escaping (TCFData) -> Void) {
    callback(getTCFDataResponse!)
  }

  func setTCFUIAsClosed() {

  }

  func setTCFUIAsOpen() {

  }

  var changeLanguageValue: String? = nil
  var changeLanguageError: Error? = nil
  func changeLanguage(language: String, onSuccess: @escaping (() -> Void), onFailure: @escaping ((Error) -> Void)) {
    changeLanguageValue = language
    if let changeLanguageError = changeLanguageError {
      onFailure(changeLanguageError)
    } else {
      onSuccess()
    }
  }

  var acceptAllForTCFConsentType: UsercentricsConsentType?
  var acceptAllForTCFFromLayer: TCFDecisionUILayer?
  var acceptAllForTCFResponse: [UsercentricsServiceConsent]?
  func acceptAllForTCF(fromLayer: TCFDecisionUILayer, consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent] {
    acceptAllForTCFFromLayer = fromLayer
    acceptAllForTCFConsentType = consentType
    return acceptAllForTCFResponse!
  }

  var acceptAllConsentType: UsercentricsConsentType?
  var acceptAllResponse: [UsercentricsServiceConsent]?
  func acceptAll(consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent] {
    acceptAllConsentType = consentType
    return acceptAllResponse!
  }

  var denyAllForTCFConsentType: UsercentricsConsentType?
  var denyAllForTCFFromLayer: TCFDecisionUILayer?
  var denyAllForTCFResponse: [UsercentricsServiceConsent]?
  func denyAllForTCF(fromLayer: TCFDecisionUILayer, consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent] {
    self.denyAllForTCFConsentType = consentType
    self.denyAllForTCFFromLayer = fromLayer
    return denyAllForTCFResponse!
  }

  var denyAllConsentType: UsercentricsConsentType?
  var denyAllResponse: [UsercentricsServiceConsent]?
  func denyAll(consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent] {
    self.denyAllConsentType = consentType
    return denyAllResponse!
  }

  var saveDecisionsForTCFResponse: [UsercentricsServiceConsent]?
  func saveDecisionsForTCF(tcfDecisions: TCFUserDecisions, fromLayer: TCFDecisionUILayer, serviceDecisions: [UserDecision], consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent] {
    return saveDecisionsForTCFResponse!
  }

  var saveDecisionsResponse: [UsercentricsServiceConsent]?
  func saveDecisions(decisions: [UserDecision], consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent] {
    return saveDecisionsResponse!
  }

  var saveOptOutForCCPAResponse: [UsercentricsServiceConsent]?
  func saveOptOutForCCPA(isOptedOut: Bool, consentType: UsercentricsConsentType) -> [UsercentricsServiceConsent] {
    return saveOptOutForCCPAResponse!
  }

  var cmpId: Int32?
  func setCMPId(id: Int32) {
    self.cmpId = id
  }

  var showFirstLayerBannerSettings: BannerSettings?
  var layoutSettings: FirstLayerStyleSettings?
  var layout: UsercentricsLayout?
  func showFirstLayer(bannerSettings: BannerSettings?,
                      hostView: UIViewController,
                      layout: UsercentricsLayout,
                      dismissViewHandler: @escaping (UsercentricsConsentUserResponse) -> Void) {
    self.showFirstLayerBannerSettings = bannerSettings
    self.layoutSettings = bannerSettings?.firstLayerStyleSettings
    self.layout = layout
  }

  var showCloseButton: Bool?
  func showSecondLayer(bannerSettings: BannerSettings?, hostView: UIViewController, dismissViewHandler: @escaping (UsercentricsConsentUserResponse) -> Void) {
    self.showCloseButton = bannerSettings?.secondLayerStyleSettings?.showCloseButton
  }
}
