import Foundation
import Usercentrics

extension UsercentricsOptions {
    convenience init?(from dictionary: NSDictionary) {
        guard let settingsId = dictionary["settingsId"] as? String else {
            return nil
        }

        let options = UsercentricsOptions(settingsId: settingsId)

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

        self.init(settingsId: settingsId,
                  defaultLanguage: options.defaultLanguage,
                  version: options.version,
                  timeoutMillis: options.timeoutMillis,
                  loggerLevel: options.loggerLevel)
    }
}

extension UsercentricsLoggerLevel {
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
