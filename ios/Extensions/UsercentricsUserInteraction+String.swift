import Foundation
import UsercentricsUI

public extension UsercentricsUserInteraction {
    func toInt() -> Int {
        switch self {
            case .acceptAll:
                return 0
            case .denyAll:
                return 1
            case .granular:
                return 2
            default:
                // NO_INTERACTION
                return 3
        }
    }
}
