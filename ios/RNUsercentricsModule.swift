//
//  RNUsercentricsModule.swift
//  RNUsercentricsModule
//
//  Copyright © 2021 Usercentrics. All rights reserved.
//

import Foundation
import Usercentrics

@objc(RNUsercentricsModule)
class RNUsercentricsModule: NSObject, RCTBridgeModule {
    @objc static func moduleName() -> String! {
        return "RNUsercentricsModule"
    }

    @objc static func requiresMainQueueSetup() -> Bool {
        return true
    }

    @objc func configure(_ dict: NSDictionary) -> Void {
        guard let userOptions = UsercentricsOptions(from: dict) else { return }
        UsercentricsCore.configure(options: userOptions)
    }
}
