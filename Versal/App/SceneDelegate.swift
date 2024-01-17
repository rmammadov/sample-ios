//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    // MARK: Internal
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
    }

    func sceneDidDisconnect(_: UIScene) {}

    func sceneDidBecomeActive(_: UIScene) {
        hidePrivacyWindow()
    }

    func sceneWillResignActive(_: UIScene) {
        showPrivacyWindow()
    }

    func sceneWillEnterForeground(_: UIScene) {}

    func sceneDidEnterBackground(_: UIScene) {}

    // MARK: Private
    private var privacyWindow: UIWindow?
    private let privacyViewController = UIHostingController(rootView: PrivacyView())
}

extension SceneDelegate {
    private func hidePrivacyWindow() {
        if let navigationController = privacyWindow?.rootViewController as? UINavigationController,
           privacyViewController == navigationController.viewControllers.first {
            privacyWindow?.isHidden = true
            privacyWindow = nil
        }
    }

    private func showPrivacyWindow() {
        guard let windowScene = window?.windowScene else {
            return
        }

        let navigationController = UINavigationController(rootViewController: privacyViewController)
        navigationController.setNavigationBarHidden(true, animated: false)

        privacyWindow?.isHidden = true
        privacyWindow = nil
        privacyWindow = UIWindow(windowScene: windowScene)
        privacyWindow?.rootViewController = navigationController
        privacyWindow?.windowLevel = .alert + 1
        privacyWindow?.makeKeyAndVisible()
    }
}
