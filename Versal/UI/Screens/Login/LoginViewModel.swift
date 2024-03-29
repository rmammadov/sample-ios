//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

protocol LoginViewModelProtocol {
    func didContentHasChanged()
    func login() async
    func validateLoginForm() async
}

final class LoginViewModel: BaseViewModel, LoginViewModelProtocol {
    static let TAG: String = "LOGIN_VIEW"

    @Published var email: String = ""
    @Published var errorMessageEmail = "error_email".localized()
    @Published var errorMessageLogin = "error_login".localized()
    @Published var isEmailValid = false
    @Published var isFormValid = true
    @Published var isSubmitEnabled = false
    @Published var isTwoFactorVerificationRequested = false
    @Published var password: String = ""

    var loginPayload: LoginPayload?

    func didContentHasChanged() {
        if email.isInputLengthAtLeast(3), password.isInputLengthAtLeast(3) {
            isSubmitEnabled = true
        } else {
            isSubmitEnabled = false
        }

        isEmailValid = true
        isFormValid = true
    }

    func login() async {
        viewState = .progress
        progressViewModel.progressState = .inProgress
        do {
            loginPayload = try await Coordinator().login(LoginPayload(email: email, password: password))
            progressViewModel.progressState = .success
            isTwoFactorVerificationRequested = true
        } catch {
            progressViewModel.progressState = .failure
        }
    }

    func validateLoginForm() async {
        isEmailValid = email.isValidEmail()

        if isEmailValid {
            await login()
        }
    }
}
