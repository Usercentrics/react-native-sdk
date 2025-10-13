import XCTest

@testable import Usercentrics
@testable import react_native_usercentrics

class UsercentricsOptionsDictTests: XCTestCase {

  func testInitializeUserOptionsFromDictionary() {
    let dict: NSDictionary = [
      "loggerLevel": 3,
      "defaultLanguage": "pt",
      "settingsId": "123",
      "ruleSetId": "qwer",
      "timeoutMillis": 1000,
      "version": "1.2.3",
      "networkMode": 1,
      "initTimeoutMillis": 1500,
    ]


    let usercentricsOptionsFromDict = UsercentricsOptions.initialize(from: dict)!

    XCTAssertEqual("123", usercentricsOptionsFromDict.settingsId)
    XCTAssertEqual("qwer", usercentricsOptionsFromDict.ruleSetId)
    XCTAssertEqual("pt", usercentricsOptionsFromDict.defaultLanguage)
    XCTAssertEqual("1.2.3", usercentricsOptionsFromDict.version)
    XCTAssertEqual(.debug, usercentricsOptionsFromDict.loggerLevel)
    XCTAssertEqual(1000, usercentricsOptionsFromDict.timeoutMillis)
    XCTAssertEqual(.eu, usercentricsOptionsFromDict.networkMode)
    XCTAssertEqual(1500, usercentricsOptionsFromDict.initTimeoutMillis)
  }

  func testInitializeWithoutSettingsIdShouldNotInitialize() {
    let dict: NSDictionary = [:]
    let usercentricsOptionsFromDict = UsercentricsOptions.initialize(from: dict)
    XCTAssertEqual(UsercentricsOptions(), usercentricsOptionsFromDict)
  }

  func testSerializeLoggerLevel() {
    let dict0: NSDictionary = [
      "loggerLevel": 0,
      "settingsId": "123",
    ]


    let dict1: NSDictionary = [
      "loggerLevel": 1,
      "settingsId": "123",
    ]


    let dict2: NSDictionary = [
      "loggerLevel": 2,
      "settingsId": "123",
    ]


    let dict3: NSDictionary = [
      "loggerLevel": 3,
      "settingsId": "123",
    ]
    XCTAssertEqual(UsercentricsLoggerLevel.none, UsercentricsOptions.initialize(from: dict0)?.loggerLevel)
    XCTAssertEqual(.error, UsercentricsOptions.initialize(from: dict1)?.loggerLevel)
    XCTAssertEqual(.warning, UsercentricsOptions.initialize(from: dict2)?.loggerLevel)
    XCTAssertEqual(.debug, UsercentricsOptions.initialize(from: dict3)?.loggerLevel)
  }

  func testSerializeNetworkMode() {
    let dict0: NSDictionary = [
      "networkMode": 0,
      "settingsId": "123",
    ]


    let dict1: NSDictionary = [
      "networkMode": 1,
      "settingsId": "123",
    ]


    let dict2: NSDictionary = [
      "settingsId": "123",
    ]
    XCTAssertEqual(.world, UsercentricsOptions.initialize(from: dict0)?.networkMode)
    XCTAssertEqual(.eu, UsercentricsOptions.initialize(from: dict1)?.networkMode)
    XCTAssertEqual(.world, UsercentricsOptions.initialize(from: dict2)?.networkMode)
  }

}
