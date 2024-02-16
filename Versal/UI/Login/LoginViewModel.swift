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

final class LoginViewModel: ObservableObject, LoginViewModelProtocol {
    // MARK: Internal
    @Published var email: String = ""
    @Published var isEmailValid = false
    @Published var isFormValid = true
    @Published var isSubmitEnabled = false
    @Published var isNextViewActive = false
    @Published var password: String = ""

    func checkLoginData() -> Bool {
        if email == emailStaticSample, password == passwordStaticSample {
            return true
        }

        return false
    }

    func validateLoginForm() {
        if email.isValidEmail(), !password.isEmpty {
            isSubmitEnabled = true
        } else {
            isSubmitEnabled = false
        }

        isEmailValid = email.isValidEmail()
        isFormValid = true
    }

    // MARK: Private
    private let emailStaticSample = "Tester@versal.money"
    private let passwordStaticSample = "123456"
}
