//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

protocol LoginViewModelProtocol {
    func checkLoginData() -> Bool
    func validateLoginForm()
}

final class LoginViewModel: BaseViewModel, LoginViewModelProtocol {
    // MARK: Internal
    static let TAG: String = "LOGIN_VIEW"

    @Published var email: String = ""
    @Published var errorMessageEmail = "error_email".localized()
    @Published var errorMessageLogin = "error_login".localized()
    @Published var isEmailValid = false
    @Published var isFormValid = true
    @Published var isSubmitEnabled = false
    @Published var isTwoFactorVerificationRequested = false
    @Published var password: String = ""

    func checkLoginData() -> Bool {
        if email == emailStaticSample, password == passwordStaticSample {
            return true
        }

        return false
    }

    func didContentHasChanged() {
        if email.isInputLengthAtLeast(3), password.isInputLengthAtLeast(3) {
            isSubmitEnabled = true
        } else {
            isSubmitEnabled = false
        }

        isEmailValid = true
        isFormValid = true
    }

    func validateLoginForm() {
        isEmailValid = email.isValidEmail()

        if isEmailValid {
            isFormValid = checkLoginData()

            isTwoFactorVerificationRequested = isFormValid == true
        }
    }

    // MARK: Private
    private let emailStaticSample = "tester@versal.money"
    private let passwordStaticSample = "123456"
}