//
//  RNUsercentricsModuleTests.swift
//  exampleTests
//
//  Created by Pedro Araujo on 21/10/2021.
//

import XCTest

@testable import react_native_usercentrics
@testable import Usercentrics

class RNUsercentricsModuleTests: XCTestCase {

  private var module: RNUsercentricsModule!
  private var fakeUsercentrics: FakeUsercentricsManager!

  override func setUp() {
    module = RNUsercentricsModule()
    fakeUsercentrics = FakeUsercentricsManager()
    module.queue = FakeDispatchQueue()
    module.rootVC = FakePresentationViewController()
    module.usercentricsManager = fakeUsercentrics
  }

  override func tearDown() {
    fakeUsercentrics = nil
    module = nil
  }

  func testModuleName() {
    XCTAssertEqual(RNUsercentricsModule.moduleName(), "RNUsercentricsModule")
  }

  func testConfigure() {
    let expectedOptions = UsercentricsOptions.mock()
    module.configure(UsercentricsOptions.asDict())
    
    XCTAssertEqual(expectedOptions.settingsId, fakeUsercentrics.configureOptions!.settingsId)
    XCTAssertEqual(expectedOptions.defaultLanguage, fakeUsercentrics.configureOptions!.defaultLanguage)
    XCTAssertEqual(expectedOptions.version, fakeUsercentrics.configureOptions!.version)
    XCTAssertEqual(expectedOptions.loggerLevel, fakeUsercentrics.configureOptions!.loggerLevel)
    XCTAssertEqual(expectedOptions.timeoutMillis, fakeUsercentrics.configureOptions!.timeoutMillis)
  }

  func testConfigureWhenIsAlreadyConfigured() {
    fakeUsercentrics.isReadySuccessCompletion = .mock()
    module.configure(UsercentricsOptions.asDict())
    XCTAssertEqual(nil, fakeUsercentrics.configureOptions)
  }

  func testConfigureWithoutCorrectValues() {
    module.configure([:])
    XCTAssertEqual(nil, fakeUsercentrics.configureOptions)
  }

  func testIsReady() {
    fakeUsercentrics.isReadySuccessCompletion = .mock()
    module.isReady { result in
      guard
        let result = result as? NSDictionary,
        let shouldShowCMP = result["shouldShowCMP"] as? Bool,
        let consentsMap = result["consents"] as? [NSDictionary],
        let consent = consentsMap.first
      else {
        XCTFail()
        return
      }

      XCTAssertEqual(shouldShowCMP, false)
      XCTAssertEqual(consent["version"] as! String, "1.2.3")
      XCTAssertEqual(consent["dataProcessor"] as! String, "BBBB")
      XCTAssertEqual(consent["templateId"] as! String, "AAAA")
      XCTAssertEqual(consent["type"] as! Int, 0)
      XCTAssertEqual(consent["status"] as! Bool, true)
    } reject: { _,_,_  in
      XCTFail("Should not go here")
    }
  }

  func testIsReadyWithError() {
    fakeUsercentrics.isReadyErrorCompletion = FakeUsercentricsError.test
    module.isReady { _ in
      XCTFail("Should not go here")
    } reject: { code, message, error in
      XCTAssertEqual(error?.localizedDescription, FakeUsercentricsError.test.localizedDescription)
      XCTAssertEqual("usercentrics_reactNative_isReady_error", code)
      XCTAssertEqual("The operation couldn’t be completed. (exampleTests.FakeUsercentricsError error 0.)", message)
    }
  }

  func testRestoreUserSession() {
    fakeUsercentrics.restoreUserSessionSuccess = .mock()
    module.restoreUserSession("abc") { [self] result in
      guard
        let result = result as? NSDictionary,
        let shouldShowCMP = result["shouldShowCMP"] as? Bool,
        let consentsMap = result["consents"] as? [NSDictionary],
        let consent = consentsMap.first
      else {
        XCTFail()
        return
      }

      XCTAssertEqual(shouldShowCMP, false)
      XCTAssertEqual(consent["version"] as! String, "1.2.3")
      XCTAssertEqual(consent["dataProcessor"] as! String, "BBBB")
      XCTAssertEqual(consent["templateId"] as! String, "AAAA")
      XCTAssertEqual(consent["type"] as! Int, 0)
      XCTAssertEqual(consent["status"] as! Bool, true)
      XCTAssertEqual(self.fakeUsercentrics.restoreControllerId, "abc")
    } reject: { _,_,_  in
      XCTFail("Should not go here")
    }
  }

  func testRestoreUserSessionWithError() {
    fakeUsercentrics.restoreUserSessionError = FakeUsercentricsError.test
    module.restoreUserSession("abc") { _ in
      XCTFail("Should not go here")
    } reject: { code, message, error in
      XCTAssertEqual(error?.localizedDescription, FakeUsercentricsError.test.localizedDescription)
      XCTAssertEqual("usercentrics_reactNative_restoreUserSession_error", code)
      XCTAssertEqual("The operation couldn’t be completed. (exampleTests.FakeUsercentricsError error 0.)", message)
    }
  }

  func testGetControllerId() {
    fakeUsercentrics.getControllerIdValue = "abc"
    module.getControllerId { response in
      XCTAssertEqual("abc", response as? String)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testGetTCString() {
    fakeUsercentrics.getTCStringValue = "abc"
    module.getTCFString { response in
      XCTAssertEqual("abc", response as? String)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testReset() {
    module.reset()
    XCTAssertEqual(1, fakeUsercentrics.resetCount)
  }

  func testGetConsents() {
    fakeUsercentrics.getConsentsResponse = [.mock()]
    module.getConsents { result in
      guard
        let result = result as? [NSDictionary],
        let consent = result.first
      else {
        XCTFail()
        return
      }

      XCTAssertEqual(consent["version"] as! String, "1.2.3")
      XCTAssertEqual(consent["dataProcessor"] as! String, "BBBB")
      XCTAssertEqual(consent["templateId"] as! String, "AAAA")
      XCTAssertEqual(consent["type"] as! Int, 0)
      XCTAssertEqual(consent["status"] as! Bool, true)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testGetUserSessionData() {
    fakeUsercentrics.getUserSessionDataResponse = "abc"
    module.getUserSessionData { result in
      guard
        let result = result as? String
      else {
        XCTFail()
        return
      }

      XCTAssertEqual("abc", result)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testGetCCPAData() {
    fakeUsercentrics.getUSPDataResponse = CCPAData(version: 1, noticeGiven: .init(bool: false), optedOut: .init(bool: false), lspact: .init(bool: false))
    module.getUSPData { result in
      guard
        let result = result as? NSDictionary
      else {
        XCTFail()
        return
      }

      XCTAssertEqual(1, result["version"] as! Int)
      XCTAssertEqual(false, result["noticeGiven"] as! Bool)
      XCTAssertEqual(false, result["optedOut"] as! Bool)
      XCTAssertEqual(false, result["lspact"] as! Bool)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testChangeLanguage() {
    module.changeLanguage("pt") { result in
      XCTAssert(result != nil)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testChangeLanguageWithError() {
    fakeUsercentrics.changeLanguageError = FakeUsercentricsError.test
    module.changeLanguage("pt") { result in
      XCTFail("Should not go here")
    } reject: { code, message, error in
      XCTAssertEqual(error?.localizedDescription, FakeUsercentricsError.test.localizedDescription)
      XCTAssertEqual("usercentrics_reactNative_changeLanguage_error", code)
      XCTAssertEqual("The operation couldn’t be completed. (exampleTests.FakeUsercentricsError error 0.)", message)
    }
  }

  func testAcceptAllExplicit() {
    fakeUsercentrics.acceptAllResponse = [.mock()]
    module.acceptAll(0) { [unowned self] result in
      guard
        let result = result as? [NSDictionary],
        let consent = result.first
      else {
        XCTFail()
        return
      }

      XCTAssertEqual(consent["version"] as! String, "1.2.3")
      XCTAssertEqual(consent["dataProcessor"] as! String, "BBBB")
      XCTAssertEqual(consent["templateId"] as! String, "AAAA")
      XCTAssertEqual(consent["type"] as! Int, 0)
      XCTAssertEqual(consent["status"] as! Bool, true)

      XCTAssertEqual(.explicit_, self.fakeUsercentrics.acceptAllConsentType!)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testAcceptAllImplicit() {
    fakeUsercentrics.acceptAllResponse = [.mock()]
    module.acceptAll(1) { [unowned self] _ in
      XCTAssertEqual(.implicit, self.fakeUsercentrics.acceptAllConsentType!)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testAcceptAllForTCF() {
    fakeUsercentrics.acceptAllForTCFResponse = [.mock()]

    module.acceptAllForTCF(0, consentType: 0) { [unowned self] result in
      guard
        let result = result as? [NSDictionary],
        let consent = result.first
      else {
        XCTFail()
        return
      }

      XCTAssertEqual(consent["version"] as! String, "1.2.3")
      XCTAssertEqual(consent["dataProcessor"] as! String, "BBBB")
      XCTAssertEqual(consent["templateId"] as! String, "AAAA")
      XCTAssertEqual(consent["type"] as! Int, 0)
      XCTAssertEqual(consent["status"] as! Bool, true)

      XCTAssertEqual(.explicit_, self.fakeUsercentrics.acceptAllForTCFConsentType!)
      XCTAssertEqual(.firstLayer, self.fakeUsercentrics.acceptAllForTCFFromLayer!)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testAcceptAllForTCFSecondLayer() {
    fakeUsercentrics.acceptAllForTCFResponse = [.mock()]

    module.acceptAllForTCF(1, consentType: 1) { [unowned self] _ in
      XCTAssertEqual(.implicit, self.fakeUsercentrics.acceptAllForTCFConsentType!)
      XCTAssertEqual(.secondLayer, self.fakeUsercentrics.acceptAllForTCFFromLayer!)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }


  func testDenyAllExplicit() {
    fakeUsercentrics.denyAllResponse = [.mock()]
    module.denyAll(0) { [unowned self] result in
      guard
        let result = result as? [NSDictionary],
        let consent = result.first
      else {
        XCTFail()
        return
      }

      XCTAssertEqual(consent["version"] as! String, "1.2.3")
      XCTAssertEqual(consent["dataProcessor"] as! String, "BBBB")
      XCTAssertEqual(consent["templateId"] as! String, "AAAA")
      XCTAssertEqual(consent["type"] as! Int, 0)
      XCTAssertEqual(consent["status"] as! Bool, true)

      XCTAssertEqual(.explicit_, self.fakeUsercentrics.denyAllConsentType!)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testDenyAllImplicit() {
    fakeUsercentrics.denyAllResponse = [.mock()]
    module.denyAll(1) { [unowned self] _ in
      XCTAssertEqual(.implicit, self.fakeUsercentrics.denyAllConsentType!)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testDenyAllForTCF() {
    fakeUsercentrics.denyAllForTCFResponse = [.mock()]

    module.denyAllForTCF(0, consentType: 0) { [unowned self] result in
      guard
        let result = result as? [NSDictionary],
        let consent = result.first
      else {
        XCTFail()
        return
      }

      XCTAssertEqual(consent["version"] as! String, "1.2.3")
      XCTAssertEqual(consent["dataProcessor"] as! String, "BBBB")
      XCTAssertEqual(consent["templateId"] as! String, "AAAA")
      XCTAssertEqual(consent["type"] as! Int, 0)
      XCTAssertEqual(consent["status"] as! Bool, true)

      XCTAssertEqual(.explicit_, self.fakeUsercentrics.denyAllForTCFConsentType!)
      XCTAssertEqual(.firstLayer, self.fakeUsercentrics.denyAllForTCFFromLayer!)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testDenyAllForTCFSecondLayer() {
    fakeUsercentrics.denyAllForTCFResponse = [.mock()]
    module.denyAllForTCF(1, consentType: 1) { [unowned self] _ in
      XCTAssertEqual(.implicit, self.fakeUsercentrics.denyAllForTCFConsentType!)
      XCTAssertEqual(.secondLayer, self.fakeUsercentrics.denyAllForTCFFromLayer!)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testSaveDecisionsForTCF() {
    fakeUsercentrics.saveDecisionsForTCFResponse = [.mock()]
    module.saveDecisionsForTCF(TCFUserDecisions.mockToDict(),
                               fromLayer: 0,
                               serviceDecisions: [UserDecision.mockToDict()],
                               consentType: 0) { result in
      guard
        let result = result as? [NSDictionary],
        let consent = result.first
      else {
        XCTFail()
        return
      }

      XCTAssertEqual(consent["version"] as! String, "1.2.3")
      XCTAssertEqual(consent["dataProcessor"] as! String, "BBBB")
      XCTAssertEqual(consent["templateId"] as! String, "AAAA")
      XCTAssertEqual(consent["type"] as! Int, 0)
      XCTAssertEqual(consent["status"] as! Bool, true)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testSaveDecisions() {
    fakeUsercentrics.saveDecisionsResponse = [.mock()]
    module.saveDecisions([UserDecision.mockToDict()], consentType: 0) { result in
      guard
        let result = result as? [NSDictionary],
        let consent = result.first
      else {
        XCTFail()
        return
      }

      XCTAssertEqual(consent["version"] as! String, "1.2.3")
      XCTAssertEqual(consent["dataProcessor"] as! String, "BBBB")
      XCTAssertEqual(consent["templateId"] as! String, "AAAA")
      XCTAssertEqual(consent["type"] as! Int, 0)
      XCTAssertEqual(consent["status"] as! Bool, true)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testSaveOptOutForCCPA() {
    fakeUsercentrics.saveOptOutForCCPAResponse = [.mock()]

    module.saveOptOutForCCPA(false, consentType: 0) { result in
      guard
        let result = result as? [NSDictionary],
        let consent = result.first
      else {
        XCTFail()
        return
      }

      XCTAssertEqual(consent["version"] as! String, "1.2.3")
      XCTAssertEqual(consent["dataProcessor"] as! String, "BBBB")
      XCTAssertEqual(consent["templateId"] as! String, "AAAA")
      XCTAssertEqual(consent["type"] as! Int, 0)
      XCTAssertEqual(consent["status"] as! Bool, true)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }
  
}
