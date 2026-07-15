import Foundation
import Usercentrics

extension BannerInitCustomization {
    convenience init?(from dictionary: NSDictionary?) {
        guard let dictionary = dictionary else { return nil }

        self.init(
            paddingTop: (dictionary["paddingTop"] as? Int32).map { KotlinInt(value: $0) },
            paddingBottom: (dictionary["paddingBottom"] as? Int32).map { KotlinInt(value: $0) },
            paddingStart: (dictionary["paddingStart"] as? Int32).map { KotlinInt(value: $0) },
            paddingEnd: (dictionary["paddingEnd"] as? Int32).map { KotlinInt(value: $0) },
            lineSpacingMultiplier: (dictionary["lineSpacingMultiplier"] as? Double).map { KotlinFloat(value: Float($0)) },
            titleFontSize: (dictionary["titleFontSize"] as? Int32).map { KotlinInt(value: $0) },
            bodyFontSize: (dictionary["bodyFontSize"] as? Int32).map { KotlinInt(value: $0) },
            linkFontSize: (dictionary["linkFontSize"] as? Int32).map { KotlinInt(value: $0) },
            titleFontBold: (dictionary["titleFontBold"] as? Bool).map { KotlinBoolean(value: $0) },
            headerPaddingTop: (dictionary["headerPaddingTop"] as? Int32).map { KotlinInt(value: $0) },
            headerPaddingSides: (dictionary["headerPaddingSides"] as? Int32).map { KotlinInt(value: $0) },
            headerPaddingBetweenElements: (dictionary["headerPaddingBetweenElements"] as? Int32).map { KotlinInt(value: $0) },
            buttonBorderColor: dictionary["buttonBorderColor"] as? String,
            buttonBorderWidth: (dictionary["buttonBorderWidth"] as? Int32).map { KotlinInt(value: $0) },
            purposeListStyle: PurposeListStyle.from(enumString: dictionary["purposeListStyle"] as? String),
            stickyHeader: (dictionary["stickyHeader"] as? Bool).map { KotlinBoolean(value: $0) },
            hideLanguageSwitcher: (dictionary["hideLanguageSwitcher"] as? Bool).map { KotlinBoolean(value: $0) },
            buttonHeightDp: (dictionary["buttonHeightDp"] as? Int32).map { KotlinInt(value: $0) },
            buttonHorizontalPaddingDp: (dictionary["buttonHorizontalPaddingDp"] as? Int32).map { KotlinInt(value: $0) },
            buttonSpacingDp: (dictionary["buttonSpacingDp"] as? Int32).map { KotlinInt(value: $0) },
            linkUnderline: (dictionary["linkUnderline"] as? Bool).map { KotlinBoolean(value: $0) },
            showSecondLayerCloseButton: (dictionary["showSecondLayerCloseButton"] as? Bool).map { KotlinBoolean(value: $0) },
            tabFontSize: (dictionary["tabFontSize"] as? Int32).map { KotlinInt(value: $0) },
            tabActiveColor: dictionary["tabActiveColor"] as? String,
            denyAllButtonBackground: dictionary["denyAllButtonBackground"] as? String,
            acceptAllButtonBackground: dictionary["acceptAllButtonBackground"] as? String,
            linkColor: dictionary["linkColor"] as? String
        )
    }
}

extension PurposeListStyle {
    static func from(enumString: String?) -> PurposeListStyle? {
        guard let enumString = enumString else { return nil }

        switch enumString {
            case "BOXED":
                return .boxed
            case "FLAT":
                return .flat
            default:
                return nil
        }
    }
}
