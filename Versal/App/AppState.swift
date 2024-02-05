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

final class AppState: ObservableObject {
    static let shared = AppState()

    var authenticationState = AuthenticationStates.locked
    @Published var current: AppStates = .background

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
}
