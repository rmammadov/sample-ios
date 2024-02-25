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
    func login(email: String, password: String)
    func logout()
    func setAuthentication(state: AuthenticationStates)
    func setCurrent(state: AppStates)
}

final class AppState: ObservableObject, AppStateProtocol {
    static let shared = AppState()

    var authenticationState = AuthenticationStates.locked
    @Published var contentState: BaseViewStates = .presentPrivacyScreen
    @Published var current: AppStates = .background
    @Published var isLoggedIn = false

    func setAuthentication(state: AuthenticationStates) {
        authenticationState = state
        if state == .authenticated {
            updateContentState()
        }
    }

    func setCurrent(state: AppStates) {
        if authenticationState != .authenticating {
            current = state
            if state == .background {
                authenticationState = .locked
            }
            updateContentState()
        }
    }

    func login(email _: String, password _: String) {
        isLoggedIn = true
    }

    func logout() {
        isLoggedIn = false
    }

    func updateAppState(viewState: BaseViewStates) {
        switch viewState {
        case .askForAuthentication:
            setAuthentication(state: .authenticating)
        case .presentContent:
            setAuthentication(state: .authenticated)
            setCurrent(state: .foreground)
        case .presentPrivacyScreen:
            setAuthentication(state: .locked)
            setCurrent(state: .background)
        }
    }

    func updateContentState() {
        if current == .foreground, authenticationState == .authenticated {
            contentState = .presentContent
        } else if current == .background {
            contentState = .presentPrivacyScreen
        } else {
            contentState = .askForAuthentication
        }
    }
}
