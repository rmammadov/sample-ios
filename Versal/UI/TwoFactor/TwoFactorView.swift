//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct TwoFactorView: View {
    // MARK: Internal
    @EnvironmentObject var appState: AppState
    @Binding var isActive: Bool

    var body: some View {
        LoginFormContainer(title: "2-Step Verification", content: {
            FormTextField(errorText: "Code is invalid",
                          isNotValid: !twoFactorViewModel.isFormValid,
                          placeHolder: "6-Digit Code",
                          title: "Enter 6-Digit Code",
                          text: $twoFactorViewModel.code)
                .onReceive(twoFactorViewModel.$code) { _ in
                    twoFactorViewModel.validateCode()
                }
                .padding(.bottom, 24)

            SolidRoundedButton(isEnabled: twoFactorViewModel.isSubmitEnabled, title: "Continue", onClick: {
                if twoFactorViewModel.verifyCode() {
                    appState.login(email: "", password: "")
                }
            })

            ReturnButton(isEnabled: true, title: "Return", onClick: {
                isActive = false
            })
            .padding(.top, 24)
        })
        .onAppear {}
    }

    // MARK: Private
    @ObservedObject private var twoFactorViewModel: TwoFactorViewModel = .init()
}
