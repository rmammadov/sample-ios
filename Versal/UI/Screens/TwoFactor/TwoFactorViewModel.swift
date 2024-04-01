//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

protocol TwoFactorViewModelProtocol {
    func validateCode()
    func submitVerification() async
}

final class TwoFactorViewModel: BaseViewModel, TwoFactorViewModelProtocol {
    // MARK: Lifecycle
    init(challengeToken: String?) {
        self.challengeToken = challengeToken
    }

    // MARK: Internal
    static let TAG: String = "TWO_FACTOR_VIEW"

    @Published var code: String = ""
    @Published var errorMessageCode = "error_code".localized()
    @Published var isFormValid = true
    @Published var isSubmitEnabled = false

    var challengeToken: String?

    let codeMaxLength = 6
    let codeMinLength = 6

    func validateCode() {
        isSubmitEnabled = code.count >= 6
        isFormValid = true
    }

    func submitVerification() async {
        setProgress(state: .inProgress)

        do {
            _ = try await Coordinator().verifyAccount(TwoFactorPayload(challenge: challengeToken, otp: code))
            setProgress(state: .success)
        } catch {
            setProgress(state: .failure)
            isFormValid = false
        }

        updateViewStateWithDelay()
        appState?.updateLoginState()
    }
}
