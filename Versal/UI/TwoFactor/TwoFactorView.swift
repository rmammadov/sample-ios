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
        LoginContainer(title: NSLocalizedString("title_two_factor", bundle: Bundle.main, comment: ""), content: {
            PlainTextField(text: $twoFactorViewModel.code,
                           autoCapitalizationType: nil,
                           errorText: twoFactorViewModel.errorMessageCode,
                           isNotValid: !twoFactorViewModel.isFormValid,
                           keyboardType: .numberPad,
                           placeHolder: NSLocalizedString("6_digit_code", bundle: Bundle.main, comment: ""),
                           title: NSLocalizedString("title_enter_6_digit_code", bundle: Bundle.main, comment: ""))
                .onReceive(twoFactorViewModel.$code) { _ in
                    twoFactorViewModel.validateCode()
                }
                .padding(.bottom, 24)

            SolidRoundedButton(isEnabled: twoFactorViewModel.isSubmitEnabled,
                               onClick: {
                                   if twoFactorViewModel.verifyCode() {
                                       appState.login(email: "", password: "")
                                   }
                               },
                               title: NSLocalizedString("btn_title_continue", bundle: Bundle.main, comment: ""))

            ReturnButton(isEnabled: true,
                         onClick: {
                             isActive = false
                         },
                         title: NSLocalizedString("btn_title_return", bundle: Bundle.main, comment: ""))
                .padding(.top, 24)
        })
        .onAppear {}
    }

    // MARK: Private
    @ObservedObject private var twoFactorViewModel: TwoFactorViewModel = .init()
}
