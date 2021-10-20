//
//  RNUsercentricsModule.swift
//  RNUsercentricsModule
//
//  Copyright © 2021 Usercentrics. All rights reserved.
//

import Foundation
import Usercentrics
import UsercentricsUI
import UIKit

@objc(RNUsercentricsModule)
class RNUsercentricsModule: NSObject, RCTBridgeModule {
    @objc static func moduleName() -> String! {
        return "RNUsercentricsModule"
    }

    @objc static func requiresMainQueueSetup() -> Bool {
        return true
    }

    @objc func configure(_ dict: NSDictionary) -> Void {
        var alreadyInitialized = false
        UsercentricsCore.isReady { _ in
            alreadyInitialized = true
        } onFailure: { _ in
            alreadyInitialized = true
        }

        if !alreadyInitialized {
            DispatchQueue.main.sync {
                guard let userOptions = UsercentricsOptions(from: dict) else { return }
                UsercentricsCore.configure(options: userOptions)
            }
        }

    }

    @objc func isReady(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        UsercentricsCore.isReady { status in
            resolve(status.toDictionary())
        } onFailure: { error in
            reject("usercentrics_reactNative_isReady_error", error.localizedDescription, nil)
        }
    }

    @objc func showCMP(_ dict: NSDictionary, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        DispatchQueue.main.async {
            guard
                let rootVC = UIApplication.shared.delegate?.window??.rootViewController,
                let settings = UsercentricsUISettings(from: dict)
            else { return }

            let predefinedUI = UsercentricsUserInterface.getPredefinedUI(settings: settings) { response in
                resolve(response.toDictionary())
                rootVC.dismiss(animated: true, completion: nil)
            }

            if #available(iOS 13.0, *) { predefinedUI.isModalInPresentation = true }
            rootVC.present(predefinedUI, animated: true, completion: nil)
        }
    }

    @objc func restoreUserSession(_ controllerId: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        UsercentricsCore.shared.restoreUserSession(controllerId: controllerId) { status in
            resolve(status.toDictionary())
        } onFailure: { error in
            reject("usercentrics_reactNative_restoreUserSession_error", error.localizedDescription, nil)
        }
    }

    @objc func getTCFString(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        resolve(UsercentricsCore.shared.getTCString())
    }

    @objc func getControllerId(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        resolve(UsercentricsCore.shared.getControllerId())
    }

    @objc func reset() -> Void {
        UsercentricsCore.reset()
    }
}
