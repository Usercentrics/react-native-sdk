import Foundation


extension UIFont {
    convenience init?(from dictionary: NSDictionary?) {
        guard let dictionary = dictionary else { return nil }

        if let customFontName = dictionary["fontName"] as? String,
           let customFontSize = dictionary["fontSize"] as? CGFloat {
            self.init(name: customFontName, size: customFontSize)
        } else {
            return nil
        }
    }
}
