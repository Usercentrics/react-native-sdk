import XCTest

@testable import react_native_usercentrics

class AgeSignalRequestTests: XCTestCase {

  func testAtLeast() {
    XCTAssertEqual(AgeSignalRequest.atLeast(age: 16, sourceLabel: "my-age-gate"),
                   AgeSignalRequest(from: ["kind": "atLeast", "age": 16, "sourceLabel": "my-age-gate"]))
    XCTAssertEqual(AgeSignalRequest.atLeast(age: 16, sourceLabel: nil),
                   AgeSignalRequest(from: ["kind": "atLeast", "age": 16]))
  }

  func testBelow() {
    XCTAssertEqual(AgeSignalRequest.below(age: 16, sourceLabel: "gate.v2_A-1"),
                   AgeSignalRequest(from: ["kind": "below", "age": 16, "sourceLabel": "gate.v2_A-1"]))
    XCTAssertEqual(AgeSignalRequest.below(age: 16, sourceLabel: nil),
                   AgeSignalRequest(from: ["kind": "below", "age": 16]))
  }

  func testBetween() {
    XCTAssertEqual(AgeSignalRequest.between(lower: 13, upper: 15, sourceLabel: "my-age-gate"),
                   AgeSignalRequest(from: ["kind": "between", "lower": 13, "upper": 15, "sourceLabel": "my-age-gate"]))
    XCTAssertEqual(AgeSignalRequest.between(lower: 13, upper: 15, sourceLabel: nil),
                   AgeSignalRequest(from: ["kind": "between", "lower": 13, "upper": 15]))
  }

  func testAgesSentAsJavaScriptNumbers() {
    // JavaScript numbers are doubles: 16 arrives as 16.0
    XCTAssertEqual(AgeSignalRequest.atLeast(age: 16, sourceLabel: nil),
                   AgeSignalRequest(from: ["kind": "atLeast", "age": 16.0]))
    XCTAssertEqual(AgeSignalRequest.atLeast(age: 0, sourceLabel: nil),
                   AgeSignalRequest(from: ["kind": "atLeast", "age": -0.0]))
    XCTAssertEqual(AgeSignalRequest.between(lower: 13, upper: 15, sourceLabel: nil),
                   AgeSignalRequest(from: ["kind": "between", "lower": 13.0, "upper": 15.0]))
  }

  func testNullLabelIsTheSameAsAMissingLabel() {
    XCTAssertEqual(AgeSignalRequest.atLeast(age: 16, sourceLabel: nil),
                   AgeSignalRequest(from: ["kind": "atLeast", "age": 16, "sourceLabel": NSNull()]))
  }

  func testKeysThatDoNotBelongToTheKindAreIgnored() {
    XCTAssertEqual(AgeSignalRequest.atLeast(age: 16, sourceLabel: nil),
                   AgeSignalRequest(from: ["kind": "atLeast", "age": 16, "lower": "x", "upper": NSNull(), "other": true]))
  }

  func testAgesAndLabelsTheNativeLayerMustJudgeAreNotJudgedHere() {
    // Not valid for the native validator, but it is the native validator that says so, with its own fixed message
    XCTAssertEqual(AgeSignalRequest.atLeast(age: 121, sourceLabel: nil), AgeSignalRequest(from: ["kind": "atLeast", "age": 121]))
    XCTAssertEqual(AgeSignalRequest.below(age: -1, sourceLabel: nil), AgeSignalRequest(from: ["kind": "below", "age": -1]))
    XCTAssertEqual(AgeSignalRequest.atLeast(age: Int32.max, sourceLabel: nil),
                   AgeSignalRequest(from: ["kind": "atLeast", "age": Double(Int32.max)]))
    XCTAssertEqual(AgeSignalRequest.atLeast(age: Int32.min, sourceLabel: nil),
                   AgeSignalRequest(from: ["kind": "atLeast", "age": Double(Int32.min)]))
    XCTAssertEqual(AgeSignalRequest.between(lower: 20, upper: 10, sourceLabel: "not a valid label!"),
                   AgeSignalRequest(from: ["kind": "between", "lower": 20, "upper": 10, "sourceLabel": "not a valid label!"]))
    XCTAssertEqual(AgeSignalRequest.atLeast(age: 16, sourceLabel: ""),
                   AgeSignalRequest(from: ["kind": "atLeast", "age": 16, "sourceLabel": ""]))

    let longLabel = String(repeating: "a", count: 100)
    XCTAssertEqual(AgeSignalRequest.atLeast(age: 16, sourceLabel: longLabel),
                   AgeSignalRequest(from: ["kind": "atLeast", "age": 16, "sourceLabel": longLabel]))
  }

  func testUnknownMissingOrNonStringKindIsRefused() {
    let requests: [NSDictionary] = [
      [:],
      ["age": 16],
      ["kind": NSNull(), "age": 16],
      ["kind": "UNKNOWN", "age": 16],
      ["kind": "ATLEAST", "age": 16],
      ["kind": "atleast", "age": 16],
      ["kind": "", "age": 16],
      ["kind": 1, "age": 16],
      ["kind": true, "age": 16],
    ]

    for (index, request) in requests.enumerated() {
      XCTAssertNil(AgeSignalRequest(from: request), "request #\(index)")
    }
  }

  func testAgeThatCannotBeHandedOverAsItIsIsRefused() {
    let notAnAge: [Any] = [
      NSNull(),
      16.5, // a fraction: intValue would take it for 16
      -0.5, // would become 0
      Double.nan, // would become 0
      Double.infinity,
      -Double.infinity,
      Double(Int32.max) + 1,
      Double(Int32.min) - 1,
      3.0e9,
      "16", // a string
      true, // a Bool is an NSNumber too: it is not the age 1
      false,
    ]

    for (index, value) in notAnAge.enumerated() {
      XCTAssertNil(AgeSignalRequest(from: ["kind": "atLeast", "age": value]), "atLeast, value #\(index)")
      XCTAssertNil(AgeSignalRequest(from: ["kind": "below", "age": value]), "below, value #\(index)")
      XCTAssertNil(AgeSignalRequest(from: ["kind": "between", "lower": value, "upper": 15]), "between lower, value #\(index)")
      XCTAssertNil(AgeSignalRequest(from: ["kind": "between", "lower": 13, "upper": value]), "between upper, value #\(index)")
    }
  }

  func testMissingAgesAreRefused() {
    XCTAssertNil(AgeSignalRequest(from: ["kind": "atLeast"]))
    XCTAssertNil(AgeSignalRequest(from: ["kind": "below"]))
    XCTAssertNil(AgeSignalRequest(from: ["kind": "between", "lower": 13]))
    XCTAssertNil(AgeSignalRequest(from: ["kind": "between", "upper": 15]))
    // atLeast and below take age only, between takes lower and upper only
    XCTAssertNil(AgeSignalRequest(from: ["kind": "between", "age": 13]))
    XCTAssertNil(AgeSignalRequest(from: ["kind": "atLeast", "lower": 13, "upper": 15]))
  }

  func testLabelThatIsNotAStringIsRefused() {
    XCTAssertNil(AgeSignalRequest(from: ["kind": "atLeast", "age": 16, "sourceLabel": 5]))
    XCTAssertNil(AgeSignalRequest(from: ["kind": "below", "age": 16, "sourceLabel": true]))
    XCTAssertNil(AgeSignalRequest(from: ["kind": "between", "lower": 13, "upper": 15, "sourceLabel": [:] as NSDictionary]))
  }

  func testARequestNeverPrintsTheAgesOrTheLabel() {
    let requests: [AgeSignalRequest] = [
      .atLeast(age: 16, sourceLabel: "my-age-gate"),
      .below(age: 17, sourceLabel: "my-age-gate"),
      .between(lower: 13, upper: 15, sourceLabel: "my-age-gate"),
    ]

    for request in requests {
      XCTAssertEqual("AgeSignalRequest", request.description)
      XCTAssertEqual("AgeSignalRequest", "\(request)")
      XCTAssertEqual("AgeSignalRequest", String(describing: request))
    }
  }
}
