import XCTest

@testable import Usercentrics
@testable import react_native_usercentrics

class ReadyStatusDictTests: XCTestCase {

  func testSerialize() {
    let usercentricsReady = UsercentricsReadyStatus(shouldShowCMP: false, consents: [.init(templateId: "abc", status: true, type: .explicit_, dataProcessor: "abc", version: "version")])
    let dictionary = usercentricsReady.toDictionary()

    XCTAssertEqual(false, dictionary["shouldShowCMP"] as! Bool)
    XCTAssertNotNil(dictionary["consents"] as? [NSDictionary])
  }

  func testSerializeConsent() {
    let consent = UsercentricsServiceConsent(templateId: "abc", status: true, type: .explicit_, dataProcessor: "abc", version: "version").toDictionary()

    XCTAssertEqual("abc", consent["templateId"] as! String)
    XCTAssertEqual(true, consent["status"] as! Bool)
    XCTAssertEqual(0, consent["type"] as! Int)
    XCTAssertEqual("abc", consent["dataProcessor"] as! String)
    XCTAssertEqual("version", consent["version"] as! String)

    let consentImplicit = UsercentricsServiceConsent(templateId: "abc", status: true, type: .implicit, dataProcessor: "abc", version: "version").toDictionary()
    XCTAssertEqual(1, consentImplicit["type"] as! Int)
  }

}
