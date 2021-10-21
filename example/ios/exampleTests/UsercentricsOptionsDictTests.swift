import XCTest

@testable import Usercentrics
@testable import react_native_usercentrics

class UsercentricsOptionsDictTests: XCTestCase {

  func testInitializeUserOptionsFromDictionary() {
    let dict: NSDictionary = [
      "loggerLevel": 3,
      "defaultLanguage": "pt",
      "settingsId": "123",
      "timeoutMillis": 1000,
      "version": "1.2.3"
    ]


    let usercentricsOptionsFromDict = UsercentricsOptions(from: dict)!

    XCTAssertEqual("123", usercentricsOptionsFromDict.settingsId)
    XCTAssertEqual("pt", usercentricsOptionsFromDict.defaultLanguage)
    XCTAssertEqual("1.2.3", usercentricsOptionsFromDict.version)
    XCTAssertEqual(.debug, usercentricsOptionsFromDict.loggerLevel)
    XCTAssertEqual(1000, usercentricsOptionsFromDict.timeoutMillis)
  }

  func testInitializeWithoutSettingsIdShouldNotInitialize() {
    let dict: NSDictionary = [:]
    let usercentricsOptionsFromDict = UsercentricsOptions(from: dict)
    XCTAssertNil(usercentricsOptionsFromDict)
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
    XCTAssertEqual(UsercentricsLoggerLevel.none, UsercentricsOptions(from: dict0)?.loggerLevel)
    XCTAssertEqual(.error, UsercentricsOptions(from: dict1)?.loggerLevel)
    XCTAssertEqual(.warning, UsercentricsOptions(from: dict2)?.loggerLevel)
    XCTAssertEqual(.debug, UsercentricsOptions(from: dict3)?.loggerLevel)
  }

}
