import Foundation
import UsercentricsUI

extension UsercentricsUserInteraction {
    func toString() -> String {
        switch self {
            case .acceptAll:
                return "ACCEPT_ALL"
            case .denyAll:
                return "DENY_ALL"
            case .granular:
                return "GRANULAR"
            case .noInteraction:
                return "NO_INTERACTION"
            @unknown default:
                assert(false)
                return "NO_INTERACTION"
        }
    }
}
