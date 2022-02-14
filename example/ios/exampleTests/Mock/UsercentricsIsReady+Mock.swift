//
//  UsercentricsIsReady+Mock.swift
//  exampleTests
//
//  Created by Pedro Araujo on 21/10/2021.
//

import Foundation
import Usercentrics

extension UsercentricsReadyStatus {
  static func mock() -> UsercentricsReadyStatus {
    return UsercentricsReadyStatus(shouldShowCMP: false, consents: [.mock(), .mock()])
  }
}

extension UsercentricsServiceConsent {
  static func mock() -> UsercentricsServiceConsent {
    return UsercentricsServiceConsent(templateId: "AAAA",
                                      status: true,
                                      history: [.mock()],
                                      type: .explicit_,
                                      dataProcessor: "BBBB",
                                      version: "1.2.3",
                                      isEssential: false)
  }
}

extension UsercentricsConsentHistoryEntry {
  static func mock() -> UsercentricsConsentHistoryEntry {
    return UsercentricsConsentHistoryEntry(status: false, type: .explicit_, timestampInMillis: Int64(123))
  }
}
