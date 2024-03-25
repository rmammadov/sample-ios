//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Moya
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

    func testRequestVersal() {
        viewState = .progress
        let provider = MoyaProvider<VersalApiTarget>()
        progressViewModel.progressState = .inProgress
        provider.request(.dpa) { result in
            switch result {
            case let .success(response):
                // Handle successful response
                print(response)
                self.progressViewModel.progressState = .success
            case let .failure(error):
                // Handle error
                self.progressViewModel.progressState = .failure
            }
        }
    }

    // MARK: Private
    private let emailStaticSample = "tester@versal.money"
    private let passwordStaticSample = "123456"
}
