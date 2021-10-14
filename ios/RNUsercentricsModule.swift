//
//  RNUsercentricsModule.swift
//  RNUsercentricsModule
//
//  Copyright © 2021 Usercentrics. All rights reserved.
//

import Foundation

@objc(RNUsercentricsModule)
class RNUsercentricsModule: NSObject {
  @objc
  func constantsToExport() -> [AnyHashable : Any]! {
    return ["count": 1]
  }

  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
