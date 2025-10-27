import XCTest

@testable import Usercentrics
@testable import react_native_usercentrics

class UsercentricsConsentTypeTests: XCTestCase {

  func testToIntMethod() {
    XCTAssertEqual(.explicit_, UsercentricsConsentType.initialize(from: 0))
    XCTAssertEqual(.implicit, UsercentricsConsentType.initialize(from: 1))
  }
}
