import XCTest

import UsercentricsUI
@testable import react_native_usercentrics

class FirstLayerOptionsDictTests: XCTestCase {

  func testMapNSTextAlignment() {
    XCTAssertEqual(.center, NSTextAlignment.from(enumString: "CENTER"))
    XCTAssertEqual(.left, NSTextAlignment.from(enumString: "LEFT"))
    XCTAssertEqual(.right, NSTextAlignment.from(enumString: "RIGHT"))
    XCTAssertNil(NSTextAlignment.from(enumString: "Abc"))
  }

  func testMapSectionPosition() {
    XCTAssertEqual(.center, SectionPosition.from(enumString: "CENTER"))
    XCTAssertEqual(.left, SectionPosition.from(enumString: "START"))
    XCTAssertEqual(.right, SectionPosition.from(enumString: "END"))
    XCTAssertNil(SectionPosition.from(enumString: "Abc"))
  }

  func testMapUsercentricsLayout() {
    XCTAssertEqual(.full, UsercentricsLayout.from(enumString: "FULL"))
    XCTAssertEqual(.popup(position: .center), UsercentricsLayout.from(enumString: "POPUP_CENTER"))
    XCTAssertEqual(.popup(position: .bottom), UsercentricsLayout.from(enumString: "POPUP_BOTTOM"))
    XCTAssertEqual(.sheet, UsercentricsLayout.from(enumString: "SHEET"))
    XCTAssertNil(UsercentricsLayout.from(enumString: "TEST"))
  }

  func testMapButtonType() {
    XCTAssertEqual(.acceptAll, ButtonType.from(enumString: "ACCEPT_ALL"))
    XCTAssertEqual(.denyAll, ButtonType.from(enumString: "DENY_ALL"))
    XCTAssertEqual(.save, ButtonType.from(enumString: "SAVE"))
    XCTAssertEqual(.more, ButtonType.from(enumString: "MORE"))
    XCTAssertNil(ButtonType.from(enumString: "Abc"))
  }

  func testMapButtonSettingsWithValidData() {
    let dict: NSDictionary = ["buttonType": "ACCEPT_ALL",
                              "font": ["fontName": "Avenir-Heavy", "fontSize": 16.0],
                              "textColorHex": "000000",
                              "backgroundColorHex": "00ff00",
                              "cornerRadius": 123]

    let buttonSettings = ButtonSettings(from: dict)
    /// TODO: Expose ButtonSettings properties for test purposes.
    XCTAssertNotNil(buttonSettings)
  }

  func testMapButtonSettingsWithInvalidData() {
    let dict: NSDictionary = ["": 1]
    let buttonSettings = ButtonSettings(from: dict)

    XCTAssertNil(buttonSettings)
  }

  func testMapButtonLayoutWithRowButtons() {
    let dict: NSDictionary = ["layout": "ROW", "buttons": [[["buttonType": "ACCEPT_ALL"], ["buttonType": "DENY_ALL"]]]]
    let buttonLayout = ButtonLayout.from(dictionary: dict)

    XCTAssertNotNil(buttonLayout)
    switch buttonLayout! {
      case .row(let buttons):
        XCTAssertEqual(2, buttons.count)
      default:
        XCTFail()
    }
  }

  func testMapButtonLayoutWithColumnButtons() {
    let dict: NSDictionary = ["layout": "COLUMN", "buttons": [[["buttonType": "ACCEPT_ALL"], ["buttonType": "DENY_ALL"]]]]
    let buttonLayout = ButtonLayout.from(dictionary: dict)

    XCTAssertNotNil(buttonLayout)
    switch buttonLayout! {
      case .column(let buttons):
        XCTAssertEqual(2, buttons.count)
      default:
        XCTFail()
    }
  }

  func testMapButtonLayoutWithGridButtons() {
    let dict: NSDictionary = ["layout": "GRID", "buttons": [[["buttonType": "ACCEPT_ALL"], ["buttonType": "DENY_ALL"]]]]
    let buttonLayout = ButtonLayout.from(dictionary: dict)

    XCTAssertNotNil(buttonLayout)
    switch buttonLayout! {
      case .grid(let buttons):
        XCTAssertEqual(1, buttons.count)
        XCTAssertEqual(2, buttons.first?.count)
      default:
        XCTFail()
    }
  }

  func testMapButtonLayoutWithInvalidButtons() {
    let dict: NSDictionary = ["": 1]
    let buttonLayout = ButtonLayout.from(dictionary: dict)

    XCTAssertNil(buttonLayout)
  }

  func testMapMessageSettingsWithValidData() {
    let dict: NSDictionary = ["fontName": "Avenir-Heavy",
                              "textSize": 16.0,
                              "textColorHex": "000000",
                              "textAlignment": "LEFT",
                              "linkTextColorHex": "ffffff",
                              "linkTextUnderline": false]
    let messageSettings = MessageSettings(from: dict)
    let expectedMessageSettings = MessageSettings(font: UIFont(name: "Avenir-Heavy", size: 16.0),
                                                  textColor: UIColor(unsafeHex: "000000"),
                                                  textAlignment: .left,
                                                  linkTextColor: UIColor(unsafeHex: "ffffff"),
                                                  linkTextUnderline: false)
    XCTAssertEqual(expectedMessageSettings, messageSettings)
  }

  func testMapMessageSettingsWithInvalidData() {
    let messageSettings = MessageSettings(from: nil)
    XCTAssertNil(messageSettings)
  }

  func testMapTitleSettingsWithValidData() {
    let dict: NSDictionary = ["fontName": "Avenir-Heavy",
                              "textSize": 16.0,
                              "textColorHex": "0f0f0f",
                              "textAlignment": "RIGHT"]
    let titleSettings = TitleSettings(from: dict)
    let expectedTitleSettings = TitleSettings(font: UIFont(name: "Avenir-Heavy", size: 16.0),
                                              textColor: UIColor(unsafeHex: "0f0f0f"),
                                              textAlignment: .right)
    XCTAssertEqual(expectedTitleSettings, titleSettings)
  }

  func testMapTitleSettingsWithFallbackFont() {
    let dict: NSDictionary = ["textColorHex": "0f0f0f",
                              "textAlignment": "RIGHT"]
    let titleSettings = TitleSettings(from: dict, fallbackFont: UIFont(name: "Avenir-Heavy", size: 16.0))
    let expectedTitleSettings = TitleSettings(font: UIFont(name: "Avenir-Heavy", size: UIFont.systemFontSize),
                                              textColor: UIColor(unsafeHex: "0f0f0f"),
                                              textAlignment: .right)
    XCTAssertEqual(expectedTitleSettings, titleSettings)
  }

  func testMapTitleWithFallbackFontAndDictFontShouldIgnoreFallback() {
    let dict: NSDictionary = ["fontName": "Avenir-Heavy",
                              "textSize": 16.0,
                              "textColorHex": "0f0f0f",
                              "textAlignment": "RIGHT"]
    let titleSettings = TitleSettings(from: dict, fallbackFont: UIFont(name: "Avenir", size: 35.0))
    let expectedTitleSettings = TitleSettings(font: UIFont(name: "Avenir-Heavy", size: 16.0),
                                              textColor: UIColor(unsafeHex: "0f0f0f"),
                                              textAlignment: .right)
    XCTAssertEqual(expectedTitleSettings, titleSettings)
  }

  func testMapTitleWithFallbackFontAndWithoutFontName() {
    let dict: NSDictionary = ["textSize": 16.0,
                              "textColorHex": "0f0f0f",
                              "textAlignment": "RIGHT"]
    let titleSettings = TitleSettings(from: dict, fallbackFont: UIFont(name: "Avenir", size: 35.0))
    let expectedTitleSettings = TitleSettings(font: UIFont(name: "Avenir", size: 16.0),
                                              textColor: UIColor(unsafeHex: "0f0f0f"),
                                              textAlignment: .right)
    XCTAssertEqual(expectedTitleSettings, titleSettings)
  }

  func testMapTitleWithoutFallbackShouldUseSystemFont() {
    let dict: NSDictionary = ["textSize": 16.0,
                              "textColorHex": "0f0f0f",
                              "textAlignment": "RIGHT"]
    let titleSettings = TitleSettings(from: dict)
    let expectedTitleSettings = TitleSettings(font: UIFont.systemFont(ofSize: 16.0),
                                              textColor: UIColor(unsafeHex: "0f0f0f"),
                                              textAlignment: .right)
    XCTAssertEqual(expectedTitleSettings, titleSettings)
  }

  func testMapTitleWithFallbackFontAndWithoutFontSize() {
    let dict: NSDictionary = ["fontName": "Avenir-Heavy",
                              "textColorHex": "0f0f0f",
                              "textAlignment": "RIGHT"]
    let titleSettings = TitleSettings(from: dict, fallbackFont: UIFont(name: "Avenir", size: 35.0))
    let expectedTitleSettings = TitleSettings(font: UIFont(name: "Avenir-Heavy", size: UIFont.systemFontSize),
                                              textColor: UIColor(unsafeHex: "0f0f0f"),
                                              textAlignment: .right)
    XCTAssertEqual(expectedTitleSettings, titleSettings)
  }

  func testMapTitleSettingsWithInvalidData() {
    let titleSettings = TitleSettings(from: nil)
    XCTAssertNil(titleSettings)
  }

  func testMapHeaderImageAsExtended() {
    let dict: NSDictionary = ["isExtended": true]
    let headerSettings = HeaderImageSettings.from(dictionary: dict)

    switch headerSettings! {
      case .extended:
        XCTAssertTrue(true)
      default:
        XCTFail()
    }
  }

  func testMapHeaderImageAsHidden() {
    let dict: NSDictionary = ["isHidden": true]
    let headerSettings = HeaderImageSettings.from(dictionary: dict)

    switch headerSettings! {
      case .hidden:
        XCTAssertTrue(true)
      default:
        XCTFail()
    }
  }

  func testMapHeaderImageAsLogo() {
    let dict: NSDictionary = ["logoUrl": "google.com"]
    let headerSettings = HeaderImageSettings.from(dictionary: dict)

    switch headerSettings! {
      case .logo(let settings):
        XCTAssertNotNil(settings)
      default:
        XCTFail()
    }
  }

  func testMapHeaderImageWithInvalidData() {
    let headerSettings = HeaderImageSettings.from(dictionary: nil)
    XCTAssertNil(headerSettings)
  }
}
