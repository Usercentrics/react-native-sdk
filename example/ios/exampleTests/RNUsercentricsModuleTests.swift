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

  func testConfigureLoggerLevelSerializer() {
    module.configure(UsercentricsOptions.asDict(mockObject: .mock(loggerLevel: .debug)))
    XCTAssertEqual(.debug, fakeUsercentrics.configureOptions!.loggerLevel)

    module.configure(UsercentricsOptions.asDict(mockObject: .mock(loggerLevel: .none)))
    XCTAssertEqual(.none, fakeUsercentrics.configureOptions!.loggerLevel)

    module.configure(UsercentricsOptions.asDict(mockObject: .mock(loggerLevel: .error)))
    XCTAssertEqual(.error, fakeUsercentrics.configureOptions!.loggerLevel)

    module.configure(UsercentricsOptions.asDict(mockObject: .mock(loggerLevel: .warning)))
    XCTAssertEqual(.warning, fakeUsercentrics.configureOptions!.loggerLevel)
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
}
