//
//  UsercentricsUISettings+Dict.swift
//  react-native-usercentrics
//
//  Created by Pedro Araujo on 18/10/2021.
//

import Foundation
import UsercentricsUI

extension UsercentricsUISettings {
    init?(from dictionary: NSDictionary) {
        let showCloseButton = dictionary["showCloseButton"] as? Bool == true

//        if let customLogo = dictionary["customLogo"] as? String {
//            settings.customLogo = deserializeImage(value: customLogo)
//        }

//        if let customFont = dictionary["customFont"] as? Dictionary<String,Any> {
//            settings.customFont = deserializeFont(value: customFont)
//        }

        self.init(customFont: nil,
                  customLogo: nil,
                  showCloseButton: showCloseButton)
    }

//    private func deserializeImage(value: String) -> UIImage? {
//        let path = assetProvider.lookupKey(forAsset: value)
//        let image = UIImage(named: path)
//        return image
//    }

//    private func deserializeFont(value: Dictionary<String,Any>) -> UIFont? {
//        if let fontAsset = value["fontAssetPath"] as? String,
//           let fontSize = value["fontSize"] as? CGFloat,
//           let url = Bundle.main.url(forResource: assetProvider.lookupKey(forAsset: fontAsset), withExtension: nil),
//           let fontDataProvider = CGDataProvider(url: url as CFURL),
//           let cgFont = CGFont(fontDataProvider),
//           let fontName = cgFont.fullName {
//
//            if let uiFont = UIFont(name: String(describing: fontName), size: fontSize) {
//                return uiFont
//            } else {
//                CTFontManagerRegisterGraphicsFont(cgFont, nil)
//                return UIFont(name: String(describing: fontName), size: fontSize)
//            }
//        }
//        return nil
//    }
}
