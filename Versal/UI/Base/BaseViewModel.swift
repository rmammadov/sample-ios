//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

public enum BaseViewStates {
    case askForAuthentication
    case presentContent
    case presentPrivacyScreen
}

protocol BaseViewModelProtocol {
    func login(email: String, password: String)
    func logout()
    func updateAppState(viewState: BaseViewStates)
}

class BaseViewModel: ObservableObject, BaseViewModelProtocol {
    // MARK: Lifecycle
    init(appState: AppState) {
        self.appState = appState

        _ = appState.objectWillChange.sink { [weak self] _ in
            self?.updateViewModel()
        }

        updateViewModel()
    }

    // MARK: Internal
    @Published var state: BaseViewStates = .presentPrivacyScreen

    var appState: AppState

    func updateAppState(viewState: BaseViewStates) {
        switch viewState {
        case .askForAuthentication:
            appState.setAuthentication(state: .authenticating)
        case .presentContent:
            appState.setAuthentication(state: .authenticated)
            appState.setCurrent(state: .foreground)
        case .presentPrivacyScreen:
            appState.setAuthentication(state: .locked)
            appState.setCurrent(state: .background)
        }
    }

    func login(email: String, password: String) {
        appState.login(email: email, password: password)
    }

    func logout() {
        appState.logout()
    }

    // MARK: Private
    private func updateViewModel() {
        if appState.current == .foreground, appState.authenticationState == .authenticated {
            state = .presentContent
        } else if appState.current == .background {
            state = .presentPrivacyScreen
        } else {
            state = .askForAuthentication
        }
    }
}
