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
    func setProgress(state: ProgressDialogState)
    func updateViewStateWithDelay()
}

class BaseViewModel: ObservableObject, BaseViewModelProtocol {
    @Published var appState: AppState?
    @Published var viewState: CurrentViewState = .normal

    let dialogViewModel = DialogViewModel()
    let progressViewModel = ProgressDialogViewModel()

    func listenAppLifecycle(appState: AppState) {
        self.appState = appState
    }

    func setProgress(state: ProgressDialogState) {
        if viewState != .progress {
            viewState = .progress
        }
        progressViewModel.updateProgressState(state)
    }

    func updateViewStateWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.viewState = .normal
        }
    }
}
