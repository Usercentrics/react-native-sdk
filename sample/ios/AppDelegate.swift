import UIKit
import React

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let jsCodeLocation: URL
        
        #if DEBUG
        jsCodeLocation = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index") ?? URL(string: "about:blank")!
        #else
        if let bundleURL = Bundle.main.url(forResource: "main", withExtension: "jsbundle") {
            jsCodeLocation = bundleURL
        } else {
            // Fallback para desenvolvimento quando bundle não existe
            jsCodeLocation = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index") ?? URL(string: "about:blank")!
        }
        #endif
        
        let rootView = RCTRootView(
            bundleURL: jsCodeLocation,
            moduleName: "sample",
            initialProperties: nil,
            launchOptions: launchOptions
        )
        
        let rootViewController = UIViewController()
        rootViewController.view = rootView
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
