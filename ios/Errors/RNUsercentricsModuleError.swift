import Foundation

public enum RNUsercentricsModuleError: Error {
    case invalidData
}

extension RNUsercentricsModuleError {
    public var errorDescription: String? {
        switch self {
            case .invalidData:
                return NSLocalizedString("Unable to execute the action", comment: "Invalid Data")
        }
    }
}
