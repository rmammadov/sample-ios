//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    var appState = AppState.shared
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let splashView = SplashView().environmentObject(appState)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: splashView)
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidBecomeActive(_: UIScene) {
        appState.setCurrent(state: .foreground)
    }

    func sceneDidDisconnect(_: UIScene) {}

    func sceneDidEnterBackground(_: UIScene) {}

    func sceneWillEnterForeground(_: UIScene) {}

    func sceneWillResignActive(_: UIScene) {
        appState.setCurrent(state: .background)
    }
}
