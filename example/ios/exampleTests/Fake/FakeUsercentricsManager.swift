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
  }

  func reset() {
    resetCount += 1
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
}
