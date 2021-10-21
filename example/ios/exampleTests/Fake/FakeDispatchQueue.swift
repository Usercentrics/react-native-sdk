import Foundation
import react_native_usercentrics

final class FakeDispatchQueue: DispatchQueueManager {
  func async(execute work: @escaping @convention(block) () -> Void) {
    work()
  }
}
