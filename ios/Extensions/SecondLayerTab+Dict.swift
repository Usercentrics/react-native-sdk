import Foundation
import Usercentrics

extension SecondLayerTab {
    // An unknown or missing value falls back to the default tab, like a tab the layout does not have.
    static func from(enumString: String?) -> SecondLayerTab? {
        switch enumString {
        case "SERVICES":
            return SecondLayerTab.services
        case "PARTNERS":
            return SecondLayerTab.partners
        default:
            return nil
        }
    }
}
