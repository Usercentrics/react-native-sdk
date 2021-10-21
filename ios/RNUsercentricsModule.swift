import Foundation
import Usercentrics
import UsercentricsUI
import UIKit

@objc(RNUsercentricsModule)
class RNUsercentricsModule: NSObject, RCTBridgeModule {

    var usercentricsManager: UsercentricsManager = UsercentricsManagerImplementation()
    var queue: DispatchQueueManager = DispatchQueue.main
    var rootVC: PresentationViewController? = UIApplication.shared.delegate?.window??.rootViewController

    @objc static func moduleName() -> String! {
        return "RNUsercentricsModule"
    }

    @objc static func requiresMainQueueSetup() -> Bool {
        return true
    }

    @objc func configure(_ dict: NSDictionary) -> Void {
        var alreadyInitialized = false
        usercentricsManager.isReady { _ in
            alreadyInitialized = true
        } onFailure: { _ in
            alreadyInitialized = true
        }

        if !alreadyInitialized {
            queue.async { [weak self] in
                guard
                    let self = self,
                    let userOptions = UsercentricsOptions(from: dict)
                else { return }

                self.usercentricsManager.configure(options: userOptions)
            }
        }
    }

    @objc func isReady(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        usercentricsManager.isReady { status in
            resolve(status.toDictionary())
        } onFailure: { error in
            reject("usercentrics_reactNative_isReady_error", error.localizedDescription, error)
        }
    }

    @objc func showCMP(_ dict: NSDictionary, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        queue.async { [weak self] in
            guard
                let self = self,
                let rootVC = self.rootVC,
                let settings = UsercentricsUISettings(from: dict)
            else {
                reject("usercentrics_reactNative_showCMP_error", RNUsercentricsModuleError.invalidData.localizedDescription, RNUsercentricsModuleError.invalidData)
                return
            }
            
            let predefinedUI = self.usercentricsManager.getPredefinedUI(settings: settings) { response in
                resolve(response.toDictionary())
                rootVC.dismiss(animated: true)
            }

            if #available(iOS 13.0, *) { predefinedUI.isModalInPresentation = true }
            rootVC.present(predefinedUI)
        }
    }

    @objc func restoreUserSession(_ controllerId: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        usercentricsManager.restoreUserSession(controllerId: controllerId) { status in
            resolve(status.toDictionary())
        } onFailure: { error in
            reject("usercentrics_reactNative_restoreUserSession_error", error.localizedDescription, error)
        }
    }

    @objc func getTCFString(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        resolve(usercentricsManager.getTCString())
    }

    @objc func getControllerId(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        resolve(usercentricsManager.getControllerId())
    }

    @objc func reset() -> Void {
        usercentricsManager.reset()
    }
}
