import XCTest

import UsercentricsUI
@testable import Usercentrics
@testable import react_native_usercentrics

class UsercentricsUISettingsDictTests: XCTestCase {
  func testSerialize() {
    let dict: NSDictionary = [
      "showCloseButton": true,
      "customFont": [
        "fontName": "Avenir",
        "fontSize": 16
      ],
      "customLogo": [
        "logoName": "logo"
      ]
    ]
    let expectedFont = UIFont(name: "Avenir", size: 16)

    let usercentricsDict = UsercentricsUISettings.init(from: dict)

    XCTAssertEqual(true, usercentricsDict?.showCloseButton)
    XCTAssertEqual(expectedFont?.fontName, usercentricsDict?.customFont?.fontName)
    XCTAssertEqual(expectedFont?.pointSize, usercentricsDict?.customFont?.pointSize)
    XCTAssertEqual(UIImage(named: "logo"), usercentricsDict?.customLogo)
  }

  func testSerializeWithNothingShouldFallbackToDefault() {
    let usercentricsDict = UsercentricsUISettings.init(from: [:])

    XCTAssertEqual(false, usercentricsDict?.showCloseButton)
    XCTAssertNil(usercentricsDict?.customFont)
    XCTAssertNil(usercentricsDict?.customLogo)
  }
}
