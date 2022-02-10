import Foundation
import UsercentricsUI

extension BannerSettings {
    init?(from dictionary: NSDictionary?) {
        guard let dictionary = dictionary else { return nil }

        self.init(font: UIFont(from: dictionary["font"] as? NSDictionary),
                  logo: UIImage(from: dictionary["logo"] as? NSDictionary))
    }
}

extension FirstLayerStyleSettings {
    init?(from dictionary: NSDictionary?) {
        guard let dictionary = dictionary else { return nil }

        self.init(headerImage: HeaderImageSettings.from(dictionary: dictionary["headerImage"] as? NSDictionary),
                  title: TitleSettings(from: dictionary["title"] as? NSDictionary),
                  message: MessageSettings(from: dictionary["message"] as? NSDictionary),
                  buttonLayout: ButtonLayout.from(dictionary: dictionary["buttonLayout"] as? NSDictionary),
                  backgroundColor: UIColor(unsafeHex: dictionary["backgroundColorHex"] as? String),
                  cornerRadius: dictionary["cornerRadius"] as? CGFloat,
                  overlayColor: UIColor(unsafeHex: dictionary["overlayColorHex"] as? String))
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
    init?(from dictionary: NSDictionary?) {
        guard let dictionary = dictionary else { return nil }

        self.init(font: UIFont(from: dictionary["font"] as? NSDictionary),
                  textColor: UIColor(unsafeHex: dictionary["textColorHex"] as? String ?? ""),
                  textAlignment: NSTextAlignment.from(enumString: dictionary["textAlignment"] as? String))
    }
}


extension MessageSettings {
    init?(from dictionary: NSDictionary?) {
        guard let dictionary = dictionary else { return nil }

        self.init(font: UIFont(from: dictionary["font"] as? NSDictionary),
                  textColor: UIColor(unsafeHex: dictionary["textColorHex"] as? String ?? ""),
                  textAlignment: NSTextAlignment.from(enumString: dictionary["textAlignment"] as? String),
                  linkTextColor: UIColor(unsafeHex: dictionary["linkTextColorHex"] as? String ?? ""),
                  linkTextUnderline: dictionary["linkTextUnderline"] as? Bool == true)
    }
}

extension ButtonLayout {
    static func from(dictionary: NSDictionary?) -> ButtonLayout? {
        guard let dictionary = dictionary else { return nil }

        let layoutDict = dictionary["layout"] as? String
        let buttons = (dictionary["buttons"] as? [[NSDictionary]]) ?? []

        switch layoutDict {
            case "ROW":
                return .row(buttons: buttons.flatMap { $0 }.compactMap { ButtonSettings(from: $0) })
            case "COLUMN":
                return .column(buttons: buttons.flatMap { $0 }.compactMap { ButtonSettings(from: $0) })
            case "GRID":
                let gridButtons = buttons.map { $0.compactMap { button in ButtonSettings(from: button) }}
                return .grid(buttons: gridButtons)
            default:
                break
        }
        
        return nil
    }
}

extension ButtonSettings {
    init?(from dictionary: NSDictionary?) {
        guard
            let dictionary = dictionary,
            let buttonType = dictionary["buttonType"] as? String
        else { return nil }

        self.init(type: ButtonType.from(enumString: buttonType),
                  font: UIFont(from: dictionary["font"] as? NSDictionary),
                  textColor: UIColor(unsafeHex: dictionary["textColorHex"] as? String),
                  backgroundColor: UIColor(unsafeHex: dictionary["backgroundColorHex"] as? String),
                  cornerRadius: dictionary["cornerRadius"] as? CGFloat)
    }
}

extension ButtonType {
    static func from(enumString: String) -> ButtonType {
        switch enumString {
            case "ACCEPT_ALL":
                return .acceptAll
            case "DENY_ALL":
                return .denyAll
            case "MORE":
                return .more
            default:
                return .save
        }
    }
}

extension UsercentricsLayout {
    static func from(enumString: String) -> UsercentricsLayout {
        switch enumString {
            case "FULL":
                return .full
            case "SHEET":
                return .sheet
            case "POPUP_CENTER":
                return .popup(position: .center)
            default:
                return .popup(position: .bottom)
        }
    }
}

extension SectionPosition {
    static func from(enumString: String?) -> SectionPosition? {
        guard let enumString = enumString else { return nil }

        switch enumString {
            case "CENTER":
                return .center
            case "RIGHT":
                return .right
            default:
                return .left
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
            default:
                return .left
        }
    }
}
