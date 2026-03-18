import Foundation
import Usercentrics

private func bridgeValue(_ value: Any) -> Any {
    switch value {
    case let dictionary as [String: Any]:
        return bridgeDictionary(dictionary)
    case let array as [Any]:
        return array.map { item in
            if let nested = item as? [String: Any] {
                return bridgeDictionary(nested)
            }
            if let nestedArray = item as? [Any] {
                return nestedArray.map { nestedItem in
                    if let nestedDict = nestedItem as? [String: Any] {
                        return bridgeDictionary(nestedDict)
                    }
                    return nestedItem
                }
            }
            return item
        } as NSArray
    default:
        return value
    }
}

private func bridgeDictionary(_ dictionary: [String: Any]) -> NSDictionary {
    let mapped = dictionary.mapValues { bridgeValue($0) }
    return mapped as NSDictionary
}

extension GppData {
    func toDictionary() -> NSDictionary {
        let bridgedSections = sections.reduce(into: [String: Any]()) { partialResult, section in
            partialResult[section.key] = bridgeDictionary(section.value)
        }

        return [
            "gppString": self.gppString,
            "applicableSections": self.applicableSections as NSArray,
            "sections": bridgedSections as NSDictionary,
        ]
    }
}
