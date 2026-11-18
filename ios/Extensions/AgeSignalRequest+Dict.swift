import Foundation

// Experimental, like the native age signal API it bridges (setAgeSignal, signal receiver mode).
//
// The request is only transported: the native layer checks the ages and the label, and answers with a fixed message that
// does not repeat them. What the bridge refuses itself is a request it cannot turn into a native signal: an unknown kind,
// an age that is missing or is not a whole number that fits an Int32 (a fraction would be silently truncated, and NaN
// or a Bool would become an age), or a label that is not a string. Nothing in here logs a request or a decision: they
// carry the ages.

/// What `Usercentrics.setAgeSignal` sends from JavaScript: one case for each factory of `UsercentricsPublisherAgeSignal`.
public enum AgeSignalRequest: Equatable, CustomStringConvertible {
    case atLeast(age: Int32, sourceLabel: String?)
    case below(age: Int32, sourceLabel: String?)
    case between(lower: Int32, upper: Int32, sourceLabel: String?)

    // Constant on purpose, like the native signal: whoever logs a request ships neither the ages nor the label
    public var description: String { "AgeSignalRequest" }
}

extension AgeSignalRequest {

    /// The request in `dict` (`kind` is "atLeast", "below" or "between", with `age`, or `lower` and `upper`, and an
    /// optional `sourceLabel`), or `nil` when it cannot be turned into a native signal. A missing key and a null value
    /// are the same thing. Keys that do not belong to the kind are ignored.
    init?(from dict: NSDictionary) {
        let sourceLabel: String?
        switch dict["sourceLabel"] {
        case nil, is NSNull:
            sourceLabel = nil
        case let label as String:
            sourceLabel = label
        default:
            return nil
        }

        switch dict["kind"] as? String {
        case "atLeast":
            guard let age = Self.wholeInt32(dict["age"]) else { return nil }
            self = .atLeast(age: age, sourceLabel: sourceLabel)
        case "below":
            guard let age = Self.wholeInt32(dict["age"]) else { return nil }
            self = .below(age: age, sourceLabel: sourceLabel)
        case "between":
            guard let lower = Self.wholeInt32(dict["lower"]), let upper = Self.wholeInt32(dict["upper"]) else { return nil }
            self = .between(lower: lower, upper: upper, sourceLabel: sourceLabel)
        default:
            return nil
        }
    }

    // `intValue` would truncate 16.5 to 16 and turn NaN into 0, that is, accept a different age than the one that was
    // sent. A Bool is an NSNumber too, and true is not the age 1.
    private static func wholeInt32(_ value: Any?) -> Int32? {
        guard let number = value as? NSNumber, CFGetTypeID(number) != CFBooleanGetTypeID() else { return nil }

        let double = number.doubleValue
        guard double == double.rounded(.down), double >= Double(Int32.min), double <= Double(Int32.max) else { return nil }
        return Int32(double)
    }
}
