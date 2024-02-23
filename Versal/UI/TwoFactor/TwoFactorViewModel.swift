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

final class TwoFactorViewModel: ObservableObject, TwoFactorViewModelProtocol {
    // MARK: Internal
    static let TAG: String = "TWO_FACTOR_VIEW"

    @Published var code: String = ""
    @Published var errorMessageCode = NSLocalizedString("error_code", bundle: Bundle.main, comment: "")
    @Published var isFormValid = true
    @Published var isSubmitEnabled = false

    func validateCode() {
        if code.count >= 6 {
            isSubmitEnabled = true
        } else {
            isSubmitEnabled = false
        }

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
