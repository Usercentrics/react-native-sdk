import Foundation
import Usercentrics

public extension UsercentricsOptions {
    static func initialize(from dictionary: NSDictionary) -> UsercentricsOptions? {
        let options = UsercentricsOptions()

        if let settingsId = dictionary["settingsId"] as? String {
            options.settingsId = settingsId
        }

        if let ruleSetId = dictionary["ruleSetId"] as? String {
            options.ruleSetId = ruleSetId
        }

        if let defaultLanguage = dictionary["defaultLanguage"] as? String {
            options.defaultLanguage = defaultLanguage
        }

        if let loggerLevelValue = dictionary["loggerLevel"] as? Int {
            options.loggerLevel = UsercentricsLoggerLevel.initialize(from: loggerLevelValue)
        }

        if let timeoutMillis = dictionary["timeoutMillis"] as? Int {
            options.timeoutMillis = Int64(timeoutMillis)
        }

        if let version = dictionary["version"] as? String {
            options.version = version
        }

        if let networkModeValue = dictionary["networkMode"] as? Int {
            options.networkMode = NetworkMode.initialize(from: networkModeValue)
        }

        if let consentMediationValue = dictionary["networkMode"] as? Bool {
            options.consentMediation = consentMediationValue
        }
        
        if let initTimeoutMillis = dictionary["initTimeoutMillis"] as? Int {
            options.initTimeoutMillis = Int64(initTimeoutMillis)
        }

        return options
    }
}

public extension UsercentricsLoggerLevel {
    static func initialize(from value: Int) -> UsercentricsLoggerLevel {
        switch value {
            case 0:
                return .none
            case 1:
                return .error
            case 2:
                return .warning
            default:
                return .debug
        }
    }
}

public extension NetworkMode {
    static func initialize(from value: Int) -> NetworkMode {
        switch value {
        case 0:
            return NetworkMode.world
        case 1:
            return NetworkMode.eu
        default:
            assert(false)
            return NetworkMode.world
        }
    }
}
