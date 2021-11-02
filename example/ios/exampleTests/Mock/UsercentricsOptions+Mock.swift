//
//  UsercentricsOptions+Mock.swift
//  exampleTests
//
//  Created by Pedro Araujo on 21/10/2021.
//

import Foundation
import Usercentrics

extension UsercentricsOptions {
  static func mock(loggerLevel: UsercentricsLoggerLevel = .warning,
                   settingsId: String = "AAAAA",
                   defaultLanguage: String = "PT",
                   version: String = "1.2.3",
                   timeoutMillis: Int64 = 1000) -> UsercentricsOptions {
    return UsercentricsOptions(settingsId: settingsId, defaultLanguage: defaultLanguage, version: version, timeoutMillis: timeoutMillis, loggerLevel: loggerLevel)
  }

  static func asDict(mockObject: UsercentricsOptions? = nil) -> NSDictionary {
    let expectedOptions = (mockObject == nil ? self.mock() : mockObject)!
    return [
      "settingsId": expectedOptions.settingsId,
      "loggerLevel": expectedOptions.loggerLevel.ordinal,
      "timeoutMillis": expectedOptions.timeoutMillis,
      "version": expectedOptions.version,
      "defaultLanguage": expectedOptions.defaultLanguage
    ]
  }
}
