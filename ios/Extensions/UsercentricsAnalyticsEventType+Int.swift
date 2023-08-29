import Usercentrics

public extension UsercentricsAnalyticsEventType {

    static func initialize(from value: Int) -> UsercentricsAnalyticsEventType? {
        guard let eventType = UsercentricsAnalyticsEventType.values().get(index: Int32(value)) else {
            assert(false)
            return nil
        }
        return eventType
    }
}
