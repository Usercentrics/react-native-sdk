import XCTest

@testable import Usercentrics
@testable import react_native_usercentrics

class UserDecisionDictTests: XCTestCase {

  func testFromDictWithCorrectValues() {
    let dict: NSDictionary = ["serviceId": "abc", "consent": false]
    let decision = UserDecision(from: dict)

    XCTAssertNotNil(decision)
    XCTAssertEqual("abc", decision!.serviceId)
    XCTAssertEqual(false, decision!.consent)
  }

  func testFromDictWithoutCorrectValuesShouldBeNil() {
    let dict: NSDictionary = ["service": "abc", "consent": false]
    let decision = UserDecision(from: dict)

    XCTAssertNil(decision)
  }
}
