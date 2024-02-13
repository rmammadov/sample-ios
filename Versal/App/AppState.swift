//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

public enum AppStates {
    case background
    case foreground
}

public enum AuthenticationStates {
    case authenticated
    case authenticating
    case locked
}

protocol AppStateProtocol {
    func setAuthentication(state: AuthenticationStates)
    func setCurrent(state: AppStates)
    func login(username: String, password: String)
    func logout()
}

final class AppState: ObservableObject, AppStateProtocol {
    static let shared = AppState()

    var authenticationState = AuthenticationStates.locked
    @Published var current: AppStates = .background
    @Published var isLoggedIn = false

    func setAuthentication(state: AuthenticationStates) {
        authenticationState = state
    }

    func setCurrent(state: AppStates) {
        if authenticationState != .authenticating {
            current = state
            if state == .background {
                authenticationState = .locked
            }
        }
    }

    func login(username _: String, password _: String) {
        isLoggedIn = true
    }

    func logout() {
        isLoggedIn = false
    }
}
