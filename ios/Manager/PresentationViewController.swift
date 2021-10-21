import Foundation
import UIKit

public protocol PresentationViewController {
    func dismiss(animated: Bool)
    func present(_ viewController: UIViewController)
}

extension UIViewController: PresentationViewController {
    public func dismiss(animated: Bool) {
        self.dismiss(animated: animated, completion: nil)
    }

    public func present(_ viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
}
