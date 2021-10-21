import Foundation
import react_native_usercentrics

final class FakePresentationViewController: PresentationViewController {
  func dismiss(animated: Bool) { }
  func present(_ viewController: UIViewController) { }
}
