import Foundation
import Usercentrics

extension UsercentricsAgeSignalDecision {

  // What a publisher signal resolves to: the SDK always tags it publisherProvided
  static func mock(band: UsercentricsAgeBand = .minor, ageLower: Int32? = 16, ageUpper: Int32? = nil) -> UsercentricsAgeSignalDecision {
    return UsercentricsAgeSignalDecision(source: .publisherProvided,
                                         trust: .publisherProvided,
                                         band: band,
                                         ageLower: ageLower.map { KotlinInt(int: $0) },
                                         ageUpper: ageUpper.map { KotlinInt(int: $0) },
                                         unavailableReason: nil)
  }

  // "No signal": no band, no trust and no ages, and the reason why
  static func mockUnavailable(reason: UsercentricsAgeSignalUnavailableReason = .notShared) -> UsercentricsAgeSignalDecision {
    return UsercentricsAgeSignalDecision(source: .googlePlayAgeSignals,
                                         trust: nil,
                                         band: nil,
                                         ageLower: nil,
                                         ageUpper: nil,
                                         unavailableReason: reason)
  }
}
