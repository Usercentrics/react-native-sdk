import Foundation
import UsercentricsUI

extension BannerSettings {
    init?(from dictionary: NSDictionary?) {
        guard let dictionary = dictionary else { return nil }

        let generalStyleSettingsDict = dictionary["generalStyleSettings"] as? NSDictionary ?? [:]

        let bannerFontHolder = BannerFontHolder(from: generalStyleSettingsDict["font"] as? NSDictionary)

        let firstLayerStyleSettingsDict = dictionary["firstLayerSettings"] as? NSDictionary
        let firstLayerSettings = FirstLayerStyleSettings(from: firstLayerStyleSettingsDict, bannerFontHolder: bannerFontHolder)

        let secondLayerStyleSettingsDict = dictionary["secondLayerSettings"] as? NSDictionary
        let secondLayerSettings = SecondLayerStyleSettings(from: secondLayerStyleSettingsDict, bannerFontHolder: bannerFontHolder)

        let toggleStyleSettingsDict = dictionary["toggleStyleSettings"] as? NSDictionary
        let toggleStyleSettings = ToggleStyleSettings(from: toggleStyleSettingsDict)

        let links = LegalLinksSettings.from(enumString: generalStyleSettingsDict["links"] as? String)
        let font = bannerFontHolder?.font
        let logo = UIImage(from: generalStyleSettingsDict["logo"] as? NSDictionary)

        let generalStyleSettings = GeneralStyleSettings(font: font,
                                                        logo: logo,
                                                        links: links,
                                                        textColor: UIColor(unsafeHex: generalStyleSettingsDict["textColorHex"] as? String),
                                                        layerBackgroundColor: UIColor(unsafeHex: generalStyleSettingsDict["layerBackgroundColorHex"] as? String),
                                                        layerBackgroundSecondaryColor: UIColor(unsafeHex: generalStyleSettingsDict["layerBackgroundSecondaryColorHex"] as? String),
                                                        linkColor: UIColor(unsafeHex: generalStyleSettingsDict["linkColorHex"] as? String),
                                                        tabColor: UIColor(unsafeHex: generalStyleSettingsDict["tabColorHex"] as? String),
                                                        bordersColor: UIColor(unsafeHex: generalStyleSettingsDict["bordersColorHex"] as? String),
                                                        toggleStyleSettings: toggleStyleSettings)

        self.init(generalStyleSettings: generalStyleSettings,
                  firstLayerStyleSettings: firstLayerSettings,
                  secondLayerStyleSettings: secondLayerSettings)
    }
}

struct BannerFontHolder {
    public let font: BannerFont

    public let regularFont: UIFont
    public let boldFont: UIFont

    init?(from dictionary: NSDictionary?) {
        guard let dictionary = dictionary,
              let regularFontName: String = dictionary["regularFont"] as? String,
              let boldFontName: String = dictionary["boldFont"] as? String,
              let fontSize: CGFloat = dictionary["fontSize"] as? CGFloat,
              let regularFont = UIFont(name: regularFontName, size: fontSize),
              let boldFont = UIFont(name: boldFontName, size: fontSize)
        else { return nil }

        self.regularFont = regularFont
        self.boldFont = boldFont
        self.font = .init(regularFont: regularFont, boldFont: boldFont)
    }
}

extension UIFont {
    static func initialize(from fontName: String?, fontSizeValue: CGFloat?, fallbackFont: UIFont?) -> UIFont? {
        let fontSize = fontSizeValue ?? UIFont.systemFontSize

        // System font with custom size
        if fontName == nil, fontSizeValue != nil {
            return fallbackFont?.withSize(fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        }

        if let fontName = fontName {
            return UIFont(name: fontName, size: fontSize)
        }

        return fallbackFont?.withSize(fontSize)
    }
}

extension FirstLayerStyleSettings {
    init?(from dictionary: NSDictionary?, bannerFontHolder: BannerFontHolder?) {
        guard let dictionary = dictionary else { return nil }

        self.init(headerImage: HeaderImageSettings.from(dictionary: dictionary["headerImage"] as? NSDictionary),
                  title: TitleSettings(from: dictionary["title"] as? NSDictionary, fallbackFont: bannerFontHolder?.boldFont),
                  message: MessageSettings(from: dictionary["message"] as? NSDictionary, fallbackFont: bannerFontHolder?.regularFont),
                  buttonLayout: ButtonLayout.from(dictionary: dictionary["buttonLayout"] as? NSDictionary, fallbackFont: bannerFontHolder?.boldFont),
                  backgroundColor: UIColor(unsafeHex: dictionary["backgroundColorHex"] as? String),
                  cornerRadius: dictionary["cornerRadius"] as? CGFloat,
                  overlayColor: UIColor(unsafeHex: dictionary["overlayColorHex"] as? String))
    }
}

extension SecondLayerStyleSettings {
    init?(from dictionary: NSDictionary?, bannerFontHolder: BannerFontHolder?) {
        guard let dictionary = dictionary else { return nil }

        self.init(buttonLayout: ButtonLayout.from(dictionary: dictionary["buttonLayout"] as? NSDictionary, fallbackFont: bannerFontHolder?.boldFont),
                  showCloseButton: dictionary["showCloseButton"] as? Bool)
    }
}

extension HeaderImageSettings {
    static func from(dictionary: NSDictionary?) -> HeaderImageSettings? {
        guard let dictionary = dictionary else { return nil }

        if let isHidden = dictionary["isHidden"] as? Bool, isHidden {
            return .hidden
        }

        let logoDict = dictionary["image"] as? NSDictionary
        let logo = UIImage(from: logoDict)

        if let isExtended = dictionary["isExtended"] as? Bool, isExtended {
            return .extended(image: logo)
        }

        let logoUrlString = logoDict?["logoUrl"] as? String

        return .logo(settings: LogoSettings(image: logo,
                                            url: URL(string: logoUrlString ?? ""),
                                            position: SectionPosition.from(enumString: dictionary["alignment"] as? String),
                                            height: dictionary["height"] as? CGFloat))
    }
}

extension TitleSettings {
    init?(from dictionary: NSDictionary?, fallbackFont: UIFont? = nil) {
        guard let dictionary = dictionary else { return nil }

        let fontName: String? = dictionary["fontName"] as? String
        let fontSize: CGFloat? = dictionary["textSize"] as? CGFloat

        self.init(font: UIFont.initialize(from: fontName, fontSizeValue: fontSize, fallbackFont: fallbackFont),
                  textColor: UIColor(unsafeHex: dictionary["textColorHex"] as? String ?? ""),
                  textAlignment: NSTextAlignment.from(enumString: dictionary["textAlignment"] as? String))
    }
}


extension MessageSettings {
    init?(from dictionary: NSDictionary?, fallbackFont: UIFont? = nil) {
        guard let dictionary = dictionary else { return nil }

        let fontName: String? = dictionary["fontName"] as? String
        let textSize: CGFloat? = dictionary["textSize"] as? CGFloat

        self.init(font: UIFont.initialize(from: fontName, fontSizeValue: textSize, fallbackFont: fallbackFont),
                  textColor: UIColor(unsafeHex: dictionary["textColorHex"] as? String ?? ""),
                  textAlignment: NSTextAlignment.from(enumString: dictionary["textAlignment"] as? String),
                  linkTextColor: UIColor(unsafeHex: dictionary["linkTextColorHex"] as? String ?? ""),
                  linkTextUnderline: dictionary["linkTextUnderline"] as? Bool ?? true)
    }
}

extension ButtonLayout {
    static func from(dictionary: NSDictionary?, fallbackFont: UIFont? = nil) -> ButtonLayout? {
        guard let dictionary = dictionary else { return nil }

        let layoutDict = dictionary["layout"] as? String
        let buttons = (dictionary["buttons"] as? [[NSDictionary]]) ?? []

        switch layoutDict {
            case "ROW":
                return .row(buttons: buttons.flatMap { $0 }.compactMap { ButtonSettings(from: $0, fallbackFont: fallbackFont) })
            case "COLUMN":
                return .column(buttons: buttons.flatMap { $0 }.compactMap { ButtonSettings(from: $0, fallbackFont: fallbackFont) })
            case "GRID":
                let gridButtons = buttons.map { $0.compactMap { button in ButtonSettings(from: button, fallbackFont: fallbackFont) }}
                return .grid(buttons: gridButtons)
            default:
                break
        }
        
        return nil
    }
}

extension ButtonSettings {
    init?(from dictionary: NSDictionary?, fallbackFont: UIFont? = nil) {
        guard
            let dictionary = dictionary,
            let buttonTypeDict = dictionary["buttonType"] as? String,
            let buttonType = ButtonType.from(enumString: buttonTypeDict)
        else { return nil }

        let fontName: String? = dictionary["fontName"] as? String
        let textSize: CGFloat? = dictionary["textSize"] as? CGFloat

        self.init(type: buttonType,
                  font: UIFont.initialize(from: fontName, fontSizeValue: textSize, fallbackFont: fallbackFont),
                  textColor: UIColor(unsafeHex: dictionary["textColorHex"] as? String),
                  backgroundColor: UIColor(unsafeHex: dictionary["backgroundColorHex"] as? String),
                  cornerRadius: dictionary["cornerRadius"] as? CGFloat)
    }
}

extension ButtonType {
    static func from(enumString: String) -> ButtonType? {
        switch enumString {
            case "ACCEPT_ALL":
                return .acceptAll
            case "DENY_ALL":
                return .denyAll
            case "MORE":
                return .more
            case "SAVE":
                return .save
            default:
                return nil
        }
    }
}

extension UsercentricsLayout {
    static func from(enumString: String) -> UsercentricsLayout? {
        switch enumString {
            case "FULL":
                return .full
            case "SHEET":
                return .sheet
            case "POPUP_CENTER":
                return .popup(position: .center)
            case "POPUP_BOTTOM":
                return .popup(position: .bottom)
            default:
                return nil
        }
    }
}

extension SectionPosition {
    static func from(enumString: String?) -> SectionPosition? {
        guard let enumString = enumString else { return nil }

        switch enumString {
            case "CENTER":
                return .center
            case "END":
                return .right
            case "START":
                return .left
            default:
                return nil
        }
    }
}

extension NSTextAlignment {
    static func from(enumString: String?) -> NSTextAlignment? {
        guard let enumString = enumString else { return nil }

        switch enumString {
            case "CENTER":
                return .center
            case "RIGHT":
                return .right
            case "LEFT":
                return .left
            default:
                return nil
        }
    }
}

extension LegalLinksSettings {
    static func from(enumString: String?) -> LegalLinksSettings? {
        guard let enumString = enumString else { return nil }

        switch enumString {
            case "BOTH":
                return .both
            case "FIRST_LAYER_ONLY":
                return .firstLayerOnly
            case "NONE":
                return LegalLinksSettings.none
            case "SECOND_LAYER_ONLY":
                return .secondLayerOnly
            default:
                return nil
        }
    }
}

extension ToggleStyleSettings {
    init?(from dictionary: NSDictionary?) {
        guard let dictionary = dictionary else { return nil }

        self.init(activeBackgroundColor: UIColor(unsafeHex: dictionary["activeBackgroundColorHex"] as? String),
                  inactiveBackgroundColor: UIColor(unsafeHex: dictionary["inactiveBackgroundColorHex"] as? String),
                  disabledBackgroundColor: UIColor(unsafeHex: dictionary["disabledBackgroundColorHex"] as? String),
                  activeThumbColor: UIColor(unsafeHex: dictionary["activeThumbColorHex"] as? String),
                  inactiveThumbColor: UIColor(unsafeHex: dictionary["inactiveThumbColorHex"] as? String),
                  disabledThumbColor: UIColor(unsafeHex: dictionary["disabledThumbColorHex"] as? String))
    }
}
