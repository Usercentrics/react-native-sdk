import Foundation
import Usercentrics

public extension UsercentricsConsentType {
    static func initialize(from value: Int) -> UsercentricsConsentType {
        switch value {
            case 0:
                return .explicit_
            default:
                return .implicit
        }
    }
}

public extension TCFDecisionUILayer {
    static func initialize(from value: Int) -> TCFDecisionUILayer {
        switch value {
            case 0:
                return .firstLayer
            default:
                return .secondLayer
        }
    }
}
