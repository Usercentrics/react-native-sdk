import UIKit
import React

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    #if DEBUG
    guard let bundleURL = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index") else {
      fatalError("Unable to find bundle URL")
    }
    #else
    guard let bundleURL = Bundle.main.url(forResource: "main", withExtension: "jsbundle") else {
      fatalError("Unable to find bundle URL")
    }
    #endif
    
    let rootView = RCTRootView(
      bundleURL: bundleURL,
      moduleName: "sample",
      initialProperties: nil,
      launchOptions: launchOptions
    )

    if #available(iOS 13.0, *) {
      rootView.backgroundColor = UIColor.systemBackground
    } else {
      rootView.backgroundColor = UIColor.white
    }

    self.window = UIWindow(frame: UIScreen.main.bounds)
    let rootViewController = UIViewController()
    rootViewController.view = rootView
    self.window?.rootViewController = rootViewController
    self.window?.makeKeyAndVisible()

    return true
  }
}
