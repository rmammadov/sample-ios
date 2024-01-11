//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation
import UIKit.UIDevice

extension UserDefaults {
    private enum Key: String, CaseIterable {
        case isUserLogedIn
        case period
        case sync
    }

    public var isUserLogedIn: Bool {
        get {
            return bool(forKey: Key.isUserLogedIn.rawValue)
        }
        set {
            set(newValue, forKey: Key.isUserLogedIn.rawValue)
            synchronize()
        }
    }

    public var period: Int {
        get {
            return integer(forKey: Key.period.rawValue)
        }
        set {
            set(newValue, forKey: Key.period.rawValue)
            synchronize()
        }
    }

    public func reset() {
        Key.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
}
