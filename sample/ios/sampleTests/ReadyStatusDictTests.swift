import XCTest

@testable import Usercentrics
@testable import react_native_usercentrics

class ReadyStatusDictTests: XCTestCase {

  func testSerialize() {
    let history = UsercentricsConsentHistoryEntry(status: false, type: .explicit_, timestampInMillis: Int64(123))
    let consent: UsercentricsServiceConsent = UsercentricsServiceConsent(templateId: "abc",
                                                                         status: true,
                                                                         history: [history],
                                                                         type: .explicit_,
                                                                         dataProcessor: "abc",
                                                                         version: "version",
                                                                         isEssential: true,
                                                                         category: "marketing")
    
    let usercentricsReady = UsercentricsReadyStatus(shouldCollectConsent: false,
                                                    consents: [consent],
                                                    geolocationRuleset: GeolocationRuleset(activeSettingsId: "settingsId", bannerRequiredAtLocation: true),
                                                    location: UsercentricsLocation(countryCode: "PT", regionCode: "PT11"))
    let dictionary = usercentricsReady.toDictionary()

    XCTAssertEqual(false, dictionary["shouldCollectConsent"] as! Bool)
    XCTAssertNotNil(dictionary["consents"] as? [NSDictionary])

    let geolocationRuleset = dictionary["geolocationRuleset"] as! NSDictionary
    XCTAssertEqual(true, geolocationRuleset["bannerRequiredAtLocation"] as! Bool)
    XCTAssertEqual("settingsId", geolocationRuleset["activeSettingsId"] as! String)

    let location = dictionary["location"] as! NSDictionary
    XCTAssertEqual("PT", location["countryCode"] as! String)
    XCTAssertEqual("PT11", location["regionCode"] as! String)
  }

  func testSerializeConsent() {
    let history = UsercentricsConsentHistoryEntry(status: false, type: .explicit_, timestampInMillis: Int64(123))
    let consent = UsercentricsServiceConsent(templateId: "abc",
                                             status: true,
                                             history: [history],
                                             type: .explicit_,
                                             dataProcessor: "abc",
                                             version: "version",
                                             isEssential: false,
                                             category: "marketing").toDictionary()

    XCTAssertEqual("abc", consent["templateId"] as! String)
    XCTAssertEqual(true, consent["status"] as! Bool)
    XCTAssertEqual(0, consent["type"] as! Int)
    XCTAssertEqual("abc", consent["dataProcessor"] as! String)
    XCTAssertEqual("version", consent["version"] as! String)
    XCTAssertEqual(false, consent["isEssential"] as! Bool)

    let historyImplicit = UsercentricsConsentHistoryEntry(status: false, type: .implicit, timestampInMillis: Int64(123))
    let consentImplicit = UsercentricsServiceConsent(templateId: "abc",
                                                     status: true,
                                                     history: [historyImplicit],
                                                     type: .implicit,
                                                     dataProcessor: "abc",
                                                     version: "version",
                                                     isEssential: false,
                                                     category: "marketing").toDictionary()

    XCTAssertEqual(1, consentImplicit["type"] as! Int)
  }

  func testSerializeConsentHistoryEntry() {
    let historyDict = [UsercentricsConsentHistoryEntry(status: false, type: .explicit_, timestampInMillis: Int64(123))].toDictionary().first!

    XCTAssertEqual(false, historyDict["status"] as! Bool)
    XCTAssertEqual(0, historyDict["type"] as! Int)
    XCTAssertEqual(123, historyDict["timestampInMillis"] as! Int)
  }

}
