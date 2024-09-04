import Foundation
import Usercentrics

extension UsercentricsOptions {
  static func mock(loggerLevel: UsercentricsLoggerLevel = .warning,
                   settingsId: String = "AAAAA",
                   ruleSetId: String = "BBBBB",
                   defaultLanguage: String = "PT",
                   version: String = "1.2.3",
                   timeoutMillis: Int64 = 1000,
                   consentMediation: Bool = true,
                   domains: UsercentricsDomains? = nil,
                   initTimeoutMillis: Int64 = 1000) -> UsercentricsOptions {
    return UsercentricsOptions(settingsId: settingsId, defaultLanguage: defaultLanguage, version: version, timeoutMillis: timeoutMillis, loggerLevel: loggerLevel, ruleSetId: ruleSetId, consentMediation: consentMediation, domains: domains, initTimeoutMillis: initTimeoutMillis)
  }

  static func asDict(mockObject: UsercentricsOptions? = nil) -> NSDictionary {
    let expectedOptions = (mockObject == nil ? self.mock() : mockObject)!
    return [
      "settingsId": expectedOptions.settingsId,
      "ruleSetId": expectedOptions.ruleSetId,
      "loggerLevel": expectedOptions.loggerLevel.ordinal,
      "timeoutMillis": expectedOptions.timeoutMillis,
      "version": expectedOptions.version,
      "defaultLanguage": expectedOptions.defaultLanguage,
      "consentMediation": expectedOptions.consentMediation,
      "initTimeoutMillis": expectedOptions.initTimeoutMillis
    ]
  }
}
