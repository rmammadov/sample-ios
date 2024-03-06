//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

protocol TwoFactorViewModelProtocol {
    func validateCode()
    func verifyCode() -> Bool
}

final class TwoFactorViewModel: BaseViewModel, TwoFactorViewModelProtocol {
    // MARK: Internal
    static let TAG: String = "TWO_FACTOR_VIEW"

    @Published var test: String = ""
    @Published var code: String = ""
    @Published var errorMessageCode = "error_code".localized()
    @Published var isFormValid = true
    @Published var isSubmitEnabled = false

    let codeMaxLength = 6
    let codeMinLength = 6

    func validateCode() {
        isSubmitEnabled = code.count >= 6
        isFormValid = true
    }

    func verifyCode() -> Bool {
        if code == codeStaticSample {
            return true
        }

        isFormValid = false

        return false
    }

    // MARK: Private
    private let codeStaticSample = "123456"
}
