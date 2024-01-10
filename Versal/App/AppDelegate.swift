//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Bugsnag
import IQKeyboardManager
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        setupBugsnag()
        setupIQKeyboardManager()

        return true
    }
}

extension AppDelegate {
    func setupBugsnag() {
        Bugsnag.start()
    }

    func setupIQKeyboardManager() {
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().keyboardDistanceFromTextField = 10
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().shouldShowToolbarPlaceholder = true
    }
}
