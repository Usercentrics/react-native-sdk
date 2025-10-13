import XCTest

@testable import Usercentrics
@testable import react_native_usercentrics

class TCFDecisionUILayerTests: XCTestCase {

  func testToIntMethod() {
    XCTAssertEqual(.firstLayer, TCFDecisionUILayer.initialize(from: 0))
    XCTAssertEqual(.secondLayer, TCFDecisionUILayer.initialize(from: 1))
  }
}
