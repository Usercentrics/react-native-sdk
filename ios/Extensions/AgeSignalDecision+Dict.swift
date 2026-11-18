import Foundation
import Usercentrics

// Experimental, like the native age signal API it bridges (setAgeSignal, signal receiver mode).
extension UsercentricsAgeSignalDecision {

    // Enums travel by their native NAME (for example "GOOGLE_PLAY_AGE_SIGNALS") and nulls stay null.
    // Nothing in here logs the decision: it carries the age.
    func toDictionary() -> NSDictionary {
        return [
            "source": source.name,
            "trust": trust?.name ?? NSNull(),
            "band": band?.name ?? NSNull(),
            "ageLower": ageLower?.intValue ?? NSNull(),
            "ageUpper": ageUpper?.intValue ?? NSNull(),
            "unavailableReason": unavailableReason?.name ?? NSNull(),
            "isAvailable": isAvailable
        ]
    }
}
