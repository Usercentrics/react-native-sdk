import XCTest

@testable import Usercentrics
@testable import react_native_usercentrics

class BannerInitCustomizationDictTests: XCTestCase {

  func testFromDictWithAllValuesSet() {
    let dict: NSDictionary = [
      "paddingTop": 16,
      "paddingBottom": 16,
      "paddingStart": 8,
      "paddingEnd": 8,
      "lineSpacingMultiplier": 1.2,
      "titleFontSize": 18,
      "bodyFontSize": 14,
      "linkFontSize": 14,
      "titleFontBold": true,
      "headerPaddingTop": 12,
      "headerPaddingSides": 12,
      "headerPaddingBetweenElements": 4,
      "buttonBorderColor": "#004dcf",
      "buttonBorderWidth": 1,
      "purposeListStyle": "FLAT",
      "stickyHeader": true,
      "hideLanguageSwitcher": false,
      "buttonHeightDp": 48,
      "buttonHorizontalPaddingDp": 16,
      "buttonSpacingDp": 8,
      "linkUnderline": true,
      "showSecondLayerCloseButton": true,
      "tabFontSize": 14,
      "tabActiveColor": "#004dcf",
      "denyAllButtonBackground": "#ffffff",
      "acceptAllButtonBackground": "#004dcf",
      "linkColor": "#004dcf",
    ]

    let customization = BannerInitCustomization(from: dict)!

    XCTAssertEqual(16, customization.paddingTop?.int32Value)
    XCTAssertEqual(16, customization.paddingBottom?.int32Value)
    XCTAssertEqual(8, customization.paddingStart?.int32Value)
    XCTAssertEqual(8, customization.paddingEnd?.int32Value)
    XCTAssertEqual(1.2, customization.lineSpacingMultiplier?.floatValue ?? -1, accuracy: 0.0001)
    XCTAssertEqual(18, customization.titleFontSize?.int32Value)
    XCTAssertEqual(14, customization.bodyFontSize?.int32Value)
    XCTAssertEqual(14, customization.linkFontSize?.int32Value)
    XCTAssertEqual(true, customization.titleFontBold?.boolValue)
    XCTAssertEqual(12, customization.headerPaddingTop?.int32Value)
    XCTAssertEqual(12, customization.headerPaddingSides?.int32Value)
    XCTAssertEqual(4, customization.headerPaddingBetweenElements?.int32Value)
    XCTAssertEqual("#004dcf", customization.buttonBorderColor)
    XCTAssertEqual(1, customization.buttonBorderWidth?.int32Value)
    XCTAssertEqual(.flat, customization.purposeListStyle)
    XCTAssertEqual(true, customization.stickyHeader?.boolValue)
    XCTAssertEqual(false, customization.hideLanguageSwitcher?.boolValue)
    XCTAssertEqual(48, customization.buttonHeightDp?.int32Value)
    XCTAssertEqual(16, customization.buttonHorizontalPaddingDp?.int32Value)
    XCTAssertEqual(8, customization.buttonSpacingDp?.int32Value)
    XCTAssertEqual(true, customization.linkUnderline?.boolValue)
    XCTAssertEqual(true, customization.showSecondLayerCloseButton?.boolValue)
    XCTAssertEqual(14, customization.tabFontSize?.int32Value)
    XCTAssertEqual("#004dcf", customization.tabActiveColor)
    XCTAssertEqual("#ffffff", customization.denyAllButtonBackground)
    XCTAssertEqual("#004dcf", customization.acceptAllButtonBackground)
    XCTAssertEqual("#004dcf", customization.linkColor)
  }

  func testFromDictWithNoValuesSetOmitsFields() {
    let dict: NSDictionary = [:]
    let customization = BannerInitCustomization(from: dict)!

    XCTAssertNil(customization.paddingTop)
    XCTAssertNil(customization.buttonBorderColor)
    XCTAssertNil(customization.purposeListStyle)
  }

  func testFromNilDictionaryReturnsNil() {
    XCTAssertNil(BannerInitCustomization(from: nil))
  }

  func testPurposeListStyleFromEnumString() {
    XCTAssertEqual(.boxed, PurposeListStyle.from(enumString: "BOXED"))
    XCTAssertEqual(.flat, PurposeListStyle.from(enumString: "FLAT"))
    XCTAssertNil(PurposeListStyle.from(enumString: "UNKNOWN"))
    XCTAssertNil(PurposeListStyle.from(enumString: nil))
  }

  func testUsercentricsOptionsBannerCustomizationFromDict() {
    let dict: NSDictionary = [
      "settingsId": "123",
      "bannerCustomization": [
        "paddingTop": 16,
        "purposeListStyle": "FLAT",
      ],
    ]

    let options = UsercentricsOptions.initialize(from: dict)!

    XCTAssertEqual(16, options.bannerCustomization?.paddingTop?.int32Value)
    XCTAssertEqual(.flat, options.bannerCustomization?.purposeListStyle)
  }
}
