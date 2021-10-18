//
//  UsercentricsUserInteraction+Dict.swift
//  react-native-usercentrics
//
//  Created by Pedro Araujo on 18/10/2021.
//

import Foundation
import UsercentricsUI

extension UsercentricsUserInteraction {
    func toString() -> String {
        switch self {
            case .acceptAll:
                return "ACCEPT_ALL"
            case .denyAll:
                return "DENY_ALL"
            case .granular:
                return "GRANULAR"
            case .noInteraction:
                return "NO_INTERACTION"
            @unknown default:
                assert(false)
                return "NO_INTERACTION"
        }
    }
}
