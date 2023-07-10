import XCTest

@testable import Usercentrics
@testable import react_native_usercentrics

class UsercentricsAnalyticsEventTypeTests: XCTestCase {

  func testInitialize() {
    XCTAssertEqual(UsercentricsAnalyticsEventType.acceptAllFirstLayer, UsercentricsAnalyticsEventType.initialize(from: 1))
  }
}
