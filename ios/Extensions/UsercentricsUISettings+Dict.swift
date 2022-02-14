import Foundation
import UsercentricsUI

public extension UsercentricsUISettings {
    init?(from dictionary: NSDictionary) {
        let showCloseButton = dictionary["showCloseButton"] as? Bool == true

        var customFont: UIFont?
        if let usercentricsFontDict = dictionary["customFont"] as? NSDictionary,
           let customFontName = usercentricsFontDict["fontName"] as? String,
           let customFontSize = usercentricsFontDict["fontSize"] as? CGFloat {

            customFont = UIFont(name: customFontName, size: customFontSize)
        }

        var customImage: UIImage?
        if let customLogoDict = dictionary["customLogo"] as? NSDictionary,
           let logoName = customLogoDict["logoName"] as? String {
            customImage = UIImage(named: logoName)
        }

        self.init(customFont: customFont,
                  customLogo: customImage,
                  showCloseButton: showCloseButton)
    }
}

