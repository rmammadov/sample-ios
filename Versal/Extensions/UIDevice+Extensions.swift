//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import UIKit

extension UIDevice {
    var iPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
    var iPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    var iPhoneX: Bool { UIScreen.main.nativeBounds.height == 2436 }

    enum ScreenType: String {
        case iPhones8 = "iPhone 8"
        case iPhones8Plus = "iPhone 8 Plus"
        case iPhones8PlusSimulators = "iPhone 8 Plus Simulators"
        case iPhonesXXS12MiniSimulator = "iPhone X or iPhone XS or iPhone 12 Mini Simulator"
        case iPhoneXR11 = "iPhone XR or iPhone 11"
        case iPhoneXSMaxProMax = "iPhone XS Max or iPhone Pro Max"
        case iPhone11Pro = "iPhone 11 Pro"
        case iPhone12Mini = "iPhone 12 Mini"
        case iPhone1212Pro = "iPhone 12 or iPhone 12 Pro"
        case iPhone12ProMax = "iPhone 12 Pro Max"
        case unknown
    }

    enum SmallOrDefaultScreenType: String {
        case iPhones8 = "iPhone 8"
        case unknown
    }

    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1334: return .iPhones8
        case 1792: return .iPhoneXR11
        case 1920: return .iPhones8Plus
        case 2208: return .iPhones8PlusSimulators
        case 2340: return .iPhone12Mini
        case 2426: return .iPhone11Pro
        case 2436: return .iPhonesXXS12MiniSimulator
        case 2532: return .iPhone1212Pro
        case 2688: return .iPhoneXSMaxProMax
        case 2778: return .iPhone12ProMax
        default: return .unknown
        }
    }

    var smallOrDefaultScreenType: SmallOrDefaultScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1334: return .iPhones8
        default: return .unknown
        }
    }
}
