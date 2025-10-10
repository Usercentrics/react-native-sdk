import XCTest

import UsercentricsUI
@testable import Usercentrics
@testable import react_native_usercentrics

class UsercentricsUserInteractionDictTest: XCTestCase {

  func testToIntMethod() {
    XCTAssertEqual(0, UsercentricsUserInteraction.acceptAll.toInt())
    XCTAssertEqual(1, UsercentricsUserInteraction.denyAll.toInt())
    XCTAssertEqual(2, UsercentricsUserInteraction.granular.toInt())
    XCTAssertEqual(3, UsercentricsUserInteraction.noInteraction.toInt())
  }
}
