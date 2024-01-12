//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

@main
struct VersalApp: App {
    // MARK: Internal
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }

    // MARK: Private
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
}
