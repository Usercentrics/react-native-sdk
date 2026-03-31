import Foundation
import UIKit

extension UIImage {
    convenience init?(from dictionary: NSDictionary?) {
        guard let dictionary = dictionary else { return nil }

        if let logoPath = dictionary["logoPath"] as? String, !logoPath.isEmpty,
           let image = Self.image(fromLogoPath: logoPath),
           let cgImage = image.cgImage {
            self.init(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
            return
        }

        if let logoName = dictionary["logoName"] as? String, !logoName.isEmpty {
            self.init(named: logoName)
            return
        }

        return nil
    }

    private static func image(fromLogoPath logoPath: String) -> UIImage? {
        if logoPath.hasPrefix("file://") {
            let path = logoPath.replacingOccurrences(of: "file://", with: "")
            if let image = UIImage(contentsOfFile: path) { return image }
        }
        else if logoPath.hasPrefix("/") {
            if let image = UIImage(contentsOfFile: logoPath) { return image }
        }
        else if logoPath.hasPrefix("http://") || logoPath.hasPrefix("https://"),
                let url = URL(string: logoPath),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
            return image
        }
        if let image = UIImage(named: logoPath) { return image }
        return nil
    }
}
