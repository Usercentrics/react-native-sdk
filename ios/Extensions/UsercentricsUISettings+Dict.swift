import Foundation
import UsercentricsUI

extension UsercentricsUISettings {
    init?(from dictionary: NSDictionary) {
        let showCloseButton = dictionary["showCloseButton"] as? Bool == true

        var customFont: UIFont?
        if let customFontName = dictionary["fontName"] as? String,
           let customFontSize = dictionary["fontSize"] as? CGFloat {
            customFont = UIFont(name: customFontName, size: customFontSize)
        }

        let customImageName = dictionary["customLogo"] as? String
        let customImage = customImageName != nil ? UIImage(named: customImageName!) : nil

        self.init(customFont: customFont,
                  customLogo: customImage,
                  showCloseButton: showCloseButton)
    }
}
