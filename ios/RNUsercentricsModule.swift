import Foundation
import Usercentrics
import UsercentricsUI
import UIKit

@objc(RNUsercentricsModule)
class RNUsercentricsModule: NSObject, RCTBridgeModule {
    
    var usercentricsManager: UsercentricsManager = UsercentricsManagerImplementation()
    var queue: DispatchQueueManager = DispatchQueue.main

    @objc static func moduleName() -> String! {
        return "RNUsercentricsModule"
    }
    
    @objc static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc func configure(_ dict: NSDictionary) -> Void {
        queue.async { [weak self] in
            guard
                let self = self,
                let userOptions = UsercentricsOptions.initialize(from: dict)
            else { return }

            self.usercentricsManager.configure(options: userOptions)
        }
    }

    @objc func isReady(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        queue.async { [weak self] in
            guard let self = self else { return }

            self.usercentricsManager.isReady { status in
                resolve(status.toDictionary())
            } onFailure: { error in
                reject("usercentrics_reactNative_isReady_error", error.localizedDescription, error)
            }
        }
    }
    
    @objc func showFirstLayer(_ dict: NSDictionary, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        queue.async { [weak self] in
            guard
                let self = self,
                let rootVC = self.getPresentationViewController(),
                let layoutString = dict["layout"] as? String,
                let layout = UsercentricsLayout.from(enumString: layoutString)
            else {
                reject("usercentrics_reactNative_showFirstLayer_error", RNUsercentricsModuleError.invalidData.localizedDescription, RNUsercentricsModuleError.invalidData)
                return
            }

            let bannerSettingsDict = dict["bannerSettings"] as? NSDictionary
            self.usercentricsManager.showFirstLayer(bannerSettings: BannerSettings(from: bannerSettingsDict),
                                                    hostView: rootVC as! UIViewController,
                                                    layout: layout) { response in
                resolve(response.toDictionary())
            }
        }
    }
    
    @objc func showSecondLayer(_ dict: NSDictionary, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        queue.async { [weak self] in
            guard
                let self = self,
                let rootVC = self.getPresentationViewController()
            else {
                reject("usercentrics_reactNative_showFirstLayer_error", RNUsercentricsModuleError.invalidData.localizedDescription, RNUsercentricsModuleError.invalidData)
                return
            }

            let bannerSettingsDict = dict["bannerSettings"] as? NSDictionary
            self.usercentricsManager.showSecondLayer(bannerSettings: BannerSettings(from: bannerSettingsDict),
                                                     hostView: rootVC as! UIViewController) { response in
                rootVC.dismiss(animated: true)
                resolve(response.toDictionary())
            }
        }
    }
    
    @objc func setCMPId(_ id: Int) -> Void {
        usercentricsManager.setCMPId(id: Int32(id))
    }
    
    @objc func restoreUserSession(_ controllerId: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        usercentricsManager.restoreUserSession(controllerId: controllerId) { status in
            resolve(status.toDictionary())
        } onFailure: { error in
            reject("usercentrics_reactNative_restoreUserSession_error", error.localizedDescription, error)
        }
    }
    
    @objc func getControllerId(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        resolve(usercentricsManager.getControllerId())
    }
    
    @objc func getConsents(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        resolve(usercentricsManager.getConsents().toListOfDictionary())
    }
    
    @objc func getCMPData(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        resolve(usercentricsManager.getCMPData().toDictionary())
    }
    
    @objc func getTCFData(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        usercentricsManager.getTCFData { tcfData in
            resolve(tcfData.toDictionary())
        }
    }
    
    @objc func getUserSessionData(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        resolve(usercentricsManager.getUserSessionData())
    }
    
    @objc func getUSPData(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        resolve(usercentricsManager.getUSPData().toDictionary())
    }
    
    @objc func changeLanguage(_ language: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        usercentricsManager.changeLanguage(language: language) {
            resolve(Void.self)
        } onFailure: { error in
            reject("usercentrics_reactNative_changeLanguage_error", error.localizedDescription, error)
        }
    }
    
    @objc func acceptAllForTCF(_ fromLayer: Int,
                               consentType: Int,
                               resolve: @escaping RCTPromiseResolveBlock,
                               reject: @escaping RCTPromiseRejectBlock) -> Void {
        let services = usercentricsManager.acceptAllForTCF(fromLayer: TCFDecisionUILayer.initialize(from: fromLayer),
                                                           consentType: UsercentricsConsentType.initialize(from: consentType))
        resolve(services.toListOfDictionary())
    }
    
    @objc func acceptAll(_ consentType: Int,
                         resolve: @escaping RCTPromiseResolveBlock,
                         reject: @escaping RCTPromiseRejectBlock) -> Void {
        let services = usercentricsManager.acceptAll(consentType: UsercentricsConsentType.initialize(from: consentType))
        resolve(services.toListOfDictionary())
    }
    
    @objc func denyAllForTCF(_ fromLayer: Int,
                             consentType: Int,
                             resolve: @escaping RCTPromiseResolveBlock,
                             reject: @escaping RCTPromiseRejectBlock) -> Void {
        let services = usercentricsManager.denyAllForTCF(fromLayer: .initialize(from: fromLayer), consentType: .initialize(from: consentType))
        resolve(services.toListOfDictionary())
    }
    
    @objc func denyAll(_ consentType: Int,
                       resolve: @escaping RCTPromiseResolveBlock,
                       reject: @escaping RCTPromiseRejectBlock) -> Void {
        let services = usercentricsManager.denyAll(consentType: .initialize(from: consentType))
        resolve(services.toListOfDictionary())
    }
    
    @objc func saveDecisionsForTCF(_ tcfDecisions: NSDictionary,
                                   fromLayer: Int,
                                   serviceDecisions: [NSDictionary],
                                   consentType: Int,
                                   resolve: @escaping RCTPromiseResolveBlock,
                                   reject: @escaping RCTPromiseRejectBlock) -> Void {
        
        let services = usercentricsManager.saveDecisionsForTCF(
            tcfDecisions: TCFUserDecisions(from: tcfDecisions),
            fromLayer: .initialize(from: fromLayer),
            serviceDecisions: serviceDecisions.compactMap { UserDecision(from: $0) },
            consentType: .initialize(from: consentType))
        resolve(services.toListOfDictionary())
        
    }
    
    @objc func saveDecisions(_ decisions: [NSDictionary],
                             consentType: Int,
                             resolve: @escaping RCTPromiseResolveBlock,
                             reject: @escaping RCTPromiseRejectBlock) -> Void {
        let services = usercentricsManager.saveDecisions(decisions: decisions.compactMap { UserDecision.init(from: $0) }, consentType: .initialize(from: consentType))
        resolve(services.toListOfDictionary())
    }
    
    @objc func saveOptOutForCCPA(_ isOptedOut: Bool,
                                 consentType: Int,
                                 resolve: @escaping RCTPromiseResolveBlock,
                                 reject: @escaping RCTPromiseRejectBlock) -> Void {
        let services = usercentricsManager.saveOptOutForCCPA(isOptedOut: isOptedOut, consentType: .initialize(from: consentType))
        resolve(services.toListOfDictionary())
    }
    
    @objc func reset() -> Void {
        usercentricsManager.reset()
    }

    func getPresentationViewController() -> PresentationViewController? {
        var window: UIWindow?
        if #available(iOS 13.0, *) {
            window = UIApplication
                .shared
                .connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            window = UIApplication.shared.windows.first { $0.isKeyWindow }
        }
        var viewController = window?.rootViewController
        while viewController?.presentedViewController != nil {
            viewController = viewController?.presentedViewController
        }
        return viewController
    }
}
