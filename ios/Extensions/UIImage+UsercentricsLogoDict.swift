import Foundation
import UIKit

extension UIImage {
    convenience init?(from dictionary: NSDictionary?) {
        guard
            let dictionary = dictionary,
            let logoName = dictionary["logoName"] as? String
        else {
            return nil
        }

        self.init(named: logoName)
    }
}
