import XCTest

import Usercentrics
import UsercentricsUI
@testable import react_native_usercentrics

class BannerSettingsDictTests: XCTestCase {

  func testFromDictWithCorrectValues() {
    let dict: NSDictionary = [
      "generalStyleSettings": [
        "font": ["fontName": "Avenir-Heavy", "fontSize": 16.0],
        "logo": ["logoName": "logo"]
      ]
    ]
    let settings = BannerSettings(from: dict)

    XCTAssertNotNil(settings)
   // XCTAssertNotNil(settings?.generalStyleSettings?.logo)
//    XCTAssertEqual("Avenir-Heavy", settings?.font?.fontName)
//    XCTAssertEqual(16.0, settings?.font?.pointSize)
  }

  func testFromDictWithLandscapeLayout() {
    let enabled = BannerSettings(from: ["generalStyleSettings": ["landscapeLayout": ["enabled": true]]])
    XCTAssertEqual(true, enabled?.generalStyleSettings?.landscapeLayout?.enabled)

    let missingFlag = BannerSettings(from: ["generalStyleSettings": ["landscapeLayout": [:]]])
    XCTAssertEqual(false, missingFlag?.generalStyleSettings?.landscapeLayout?.enabled)

    let absent = BannerSettings(from: ["generalStyleSettings": ["textColorHex": "#000000"]])
    XCTAssertNil(absent?.generalStyleSettings?.landscapeLayout)
  }

  func testFromDictWithIncorrectValues() {
    let dict: NSDictionary = ["font": ["fontName": "", "fontSize": ""], "logo": ["logoName": ""]]
    let settings = BannerSettings(from: dict)

    XCTAssertNotNil(settings)
    XCTAssertNil(settings?.generalStyleSettings?.logo)
    XCTAssertNil(settings?.generalStyleSettings?.font)
  }

  func testFromDictWithInitCustomization() {
    let dict: NSDictionary = [
      "initCustomization": [
        "paddingTop": 16,
        "purposeListStyle": "FLAT",
      ]
    ]
    let settings = BannerSettings(from: dict)

    XCTAssertNotNil(settings?.initCustomization)
    XCTAssertEqual(16, settings?.initCustomization?.paddingTop?.int32Value)
    XCTAssertEqual(.flat, settings?.initCustomization?.purposeListStyle)
  }
}
