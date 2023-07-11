
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

  func testConfigureWithoutCorrectValues() {
    module.configure([:])
    XCTAssertEqual(UsercentricsOptions(), fakeUsercentrics.configureOptions)
  }

  func testIsReady() {
    fakeUsercentrics.isReadySuccessCompletion = .mock()
    module.isReady { result in
      guard
        let result = result as? NSDictionary,
        let shouldCollectConsent = result["shouldCollectConsent"] as? Bool,
        let consentsMap = result["consents"] as? [NSDictionary],
        let consent = consentsMap.first
      else {
        XCTFail()
        return
      }

      XCTAssertEqual(shouldCollectConsent, false)
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
        let shouldCollectConsent = result["shouldCollectConsent"] as? Bool,
        let consentsMap = result["consents"] as? [NSDictionary],
        let consent = consentsMap.first
      else {
        XCTFail()
        return
      }

      XCTAssertEqual(shouldCollectConsent, false)
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

  func testGetABTestingVariantId() {
    fakeUsercentrics.getABTestingVariantValue = "variantA"
    module.getABTestingVariant { response in
      XCTAssertEqual("variantA", response as? String)
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
      XCTAssertEqual("1NNN", result["uspString"] as! String)
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

  func testGetTCFData() {
    fakeUsercentrics.getTCFDataResponse = .mock()
    module.getTCFData { result in
      guard
        let result = result as? NSDictionary
      else {
        XCTFail()
        return
      }

      let features = result["features"] as? [NSDictionary]
      let purposes = result["purposes"] as? [NSDictionary]
      let specialFeatures = result["specialFeatures"] as? [NSDictionary]
      let specialPurposes = result["specialPurposes"] as? [NSDictionary]
      let stacks = result["stacks"] as? [NSDictionary]
      let vendors = result["vendors"] as? [NSDictionary]

      XCTAssertNotNil(features)
      XCTAssertNotNil(purposes)
      XCTAssertNotNil(specialFeatures)
      XCTAssertNotNil(specialPurposes)
      XCTAssertNotNil(stacks)
      XCTAssertNotNil(vendors)

      XCTAssertEqual(1, features!.count)
      XCTAssertEqual(1, purposes!.count)
      XCTAssertEqual(1, specialFeatures!.count)
      XCTAssertEqual(1, specialPurposes!.count)
      XCTAssertEqual(1, stacks!.count)
      XCTAssertEqual(1, vendors!.count)

      XCTAssertEqual(TCFFeature.mock().toDictionary(), features!.first)
      XCTAssertEqual(TCFPurpose.mock().toDictionary(), purposes!.first)
      XCTAssertEqual(TCFSpecialFeature.mock().toDictionary(), specialFeatures!.first)
      XCTAssertEqual(TCFSpecialPurpose.mock().toDictionary(), specialPurposes!.first)
      XCTAssertEqual(TCFStack.mock().toDictionary(), stacks!.first)
      XCTAssertEqual(TCFVendor.mock().toDictionary(), vendors!.first)

    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testSetCMPId() {
    module.setCMPId(123)
    XCTAssertEqual(Int32(123), fakeUsercentrics.cmpId)
  }

  func testSetABTestingVariant() {
    module.setABTestingVariant("variantA")
    XCTAssertEqual(String("variantA"), fakeUsercentrics.variant)
  }

  func testShowFirstLayer() {
    let serializedSettings: NSDictionary = [
      "firstLayerStyleSettings": ["layout": "POPUP_CENTER"]
    ]
    module.showFirstLayer(serializedSettings) { result in
      XCTAssertEqual(.popup(position: .center), self.fakeUsercentrics.showFirstLayerBannerSettings?.firstLayerStyleSettings?.layout)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testShowSecondLayer() {
    let serializedSettings: NSDictionary = [
      "secondLayerStyleSettings": ["showCloseButton": true]
    ]
    module.showSecondLayer(serializedSettings) { result in
      XCTAssertEqual(true, self.fakeUsercentrics.showSecondLayerBannerSettings?.secondLayerStyleSettings?.showCloseButton)
    } reject: { _, _, _ in
      XCTFail("Should not go here")
    }
  }

  func testTrack() {
    module.track(1)
    XCTAssertEqual(1, fakeUsercentrics.trackCalls.count)
    XCTAssertEqual(UsercentricsAnalyticsEventType.acceptAllFirstLayer, fakeUsercentrics.trackCalls[0])
  }
}
