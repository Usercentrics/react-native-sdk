//
//  UsercentricsManager.swift
//  RNUsercentricsModule
//
//  Created by Pedro Araujo on 21/10/2021.
//  Copyright © 2021 Usercentrics. All rights reserved.
//

import Foundation
import Usercentrics
import UsercentricsUI

public protocol UsercentricsManager {
    func isReady(onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void))
    func configure(options: UsercentricsOptions)
    func reset()
    func getPredefinedUI(settings: UsercentricsUISettings?, dismissViewHandler: @escaping (UsercentricsConsentUserResponse) -> Void) -> UIViewController
    func restoreUserSession(controllerId: String, onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void))
    func getTCString() -> String
    func getControllerId() -> String
}

final class UsercentricsManagerImplementation: UsercentricsManager {

    func isReady(onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void)) {
        UsercentricsCore.isReady(onSuccess: onSuccess, onFailure: onFailure)
    }

    func configure(options: UsercentricsOptions) {
        UsercentricsCore.configure(options: options)
    }

    func reset() {
        UsercentricsCore.reset()
    }

    func getPredefinedUI(settings: UsercentricsUISettings?, dismissViewHandler: @escaping (UsercentricsConsentUserResponse) -> Void) -> UIViewController {
        return UsercentricsUserInterface.getPredefinedUI(settings: settings, dismissViewHandler: dismissViewHandler)
    }

    func restoreUserSession(controllerId: String, onSuccess: @escaping ((UsercentricsReadyStatus) -> Void), onFailure: @escaping ((Error) -> Void)) {
        UsercentricsCore.shared.restoreUserSession(controllerId: controllerId, onSuccess: onSuccess, onFailure: onFailure)
    }

    func getTCString() -> String {
        return UsercentricsCore.shared.getTCString()
    }

    func getControllerId() -> String {
        return UsercentricsCore.shared.getControllerId()
    }
}
