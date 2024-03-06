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
    func listenAppLifecycle(appState: AppState)
}

class BaseViewModel: ObservableObject, BaseViewModelProtocol {
    @Published var appState: AppState?

    func listenAppLifecycle(appState: AppState) {
        self.appState = appState
    }
}
