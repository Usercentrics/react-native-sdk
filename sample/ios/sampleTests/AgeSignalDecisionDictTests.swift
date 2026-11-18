import XCTest

@testable import Usercentrics
@testable import react_native_usercentrics

class AgeSignalDecisionDictTests: XCTestCase {

  func testSerializeAvailableDecision() {
    let dictionary = UsercentricsAgeSignalDecision.mock(band: .minor, ageLower: 16, ageUpper: nil).toDictionary()

    XCTAssertEqual("PUBLISHER_PROVIDED", dictionary["source"] as? String)
    XCTAssertEqual("PUBLISHER_PROVIDED", dictionary["trust"] as? String)
    XCTAssertEqual("MINOR", dictionary["band"] as? String)
    XCTAssertEqual(16, dictionary["ageLower"] as? Int)
    XCTAssertTrue(dictionary["ageUpper"] is NSNull)
    XCTAssertTrue(dictionary["unavailableReason"] is NSNull)
    XCTAssertEqual(true, dictionary["isAvailable"] as? Bool)
    XCTAssertEqual(["source", "trust", "band", "ageLower", "ageUpper", "unavailableReason", "isAvailable"].sorted(),
                   (dictionary.allKeys as? [String])?.sorted())
  }

  func testSerializeBothAgesOfARange() {
    let dictionary = UsercentricsAgeSignalDecision.mock(band: .belowMinimum, ageLower: 0, ageUpper: 12).toDictionary()

    XCTAssertEqual("BELOW_MINIMUM", dictionary["band"] as? String)
    XCTAssertEqual(0, dictionary["ageLower"] as? Int)
    XCTAssertEqual(12, dictionary["ageUpper"] as? Int)
    XCTAssertEqual(true, dictionary["isAvailable"] as? Bool)
  }

  func testSerializeDecisionWithoutBandKeepsTheNulls() {
    let dictionary = UsercentricsAgeSignalDecision.mockUnavailable(reason: .notShared).toDictionary()

    XCTAssertEqual("GOOGLE_PLAY_AGE_SIGNALS", dictionary["source"] as? String)
    XCTAssertEqual("NOT_SHARED", dictionary["unavailableReason"] as? String)
    XCTAssertTrue(dictionary["trust"] is NSNull)
    XCTAssertTrue(dictionary["band"] is NSNull)
    XCTAssertTrue(dictionary["ageLower"] is NSNull)
    XCTAssertTrue(dictionary["ageUpper"] is NSNull)
    XCTAssertEqual(false, dictionary["isAvailable"] as? Bool)
  }

  func testSerializeWritesTheNativeNameOfEveryEnumMember() {
    for source in UsercentricsAgeSignalSource.entries {
      let decision = UsercentricsAgeSignalDecision(source: source, trust: nil, band: nil, ageLower: nil, ageUpper: nil, unavailableReason: nil)
      XCTAssertEqual(source.name, decision.toDictionary()["source"] as? String)
    }
    for trust in UsercentricsAgeSignalTrust.entries {
      let decision = UsercentricsAgeSignalDecision(source: .publisherProvided, trust: trust, band: nil, ageLower: nil, ageUpper: nil, unavailableReason: nil)
      XCTAssertEqual(trust.name, decision.toDictionary()["trust"] as? String)
    }
    for band in UsercentricsAgeBand.entries {
      XCTAssertEqual(band.name, UsercentricsAgeSignalDecision.mock(band: band).toDictionary()["band"] as? String)
    }
    for reason in UsercentricsAgeSignalUnavailableReason.entries {
      XCTAssertEqual(reason.name, UsercentricsAgeSignalDecision.mockUnavailable(reason: reason).toDictionary()["unavailableReason"] as? String)
    }
  }

  func testTheNativeEnumsHaveExactlyTheMembersOfTheJavaScriptAndAndroidEnums() {
    // The names travel as they are: a member that is added or renamed natively must be added to the bridges too
    XCTAssertEqual(["BELOW_MINIMUM", "MINOR", "STANDARD"], UsercentricsAgeBand.entries.map { $0.name })
    XCTAssertEqual(["APPLE_DECLARED_AGE_RANGE", "GOOGLE_PLAY_AGE_SIGNALS", "PUBLISHER_PROVIDED"],
                   UsercentricsAgeSignalSource.entries.map { $0.name })
    XCTAssertEqual(["SELF_DECLARED", "GUARDIAN_DECLARED", "VERIFIED", "PUBLISHER_PROVIDED"],
                   UsercentricsAgeSignalTrust.entries.map { $0.name })
    XCTAssertEqual(["DECLINED", "NOT_SHARED", "VERIFICATION_REQUIRED", "UNSUPPORTED", "NOT_AVAILABLE",
                    "INVALID_REQUEST", "TRANSIENT_ERROR", "TIMEOUT", "ERROR"],
                   UsercentricsAgeSignalUnavailableReason.entries.map { $0.name })
  }
}
