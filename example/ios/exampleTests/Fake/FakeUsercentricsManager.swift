//
//  FakeUsercentricsManager.swift
//  exampleTests
//
//  Created by Pedro Araujo on 21/10/2021.
//

import Foundation
import react_native_usercentrics
import Usercentrics
import UsercentricsUI

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

  func getPredefinedUI(settings: UsercentricsUISettings?, dismissViewHandler: @escaping (UsercentricsConsentUserResponse) -> Void) -> UIViewController {
    return UIViewController()
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

  func getTCString() -> String {
    return getTCStringValue!
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
  func getTCFData() -> TCFData {
    return getTCFDataResponse!
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
}
