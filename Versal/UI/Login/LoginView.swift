//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct LoginView: View {
    // MARK: Internal
    @EnvironmentObject var appState: AppState

    var body: some View {
        LoginContainer(title: NSLocalizedString("title_sign_in", bundle: Bundle.main, comment: ""), content: {
            PlainTextField(text: $loginViewModel.email,
                           autoCapitalizationType: nil,
                           errorText: loginViewModel.errorMessageEmail,
                           isNotValid: !loginViewModel.isEmailValid,
                           keyboardType: .emailAddress,
                           placeHolder: nil,
                           title: NSLocalizedString("email", bundle: Bundle.main, comment: ""))
                .onReceive(loginViewModel.$email) { _ in
                    loginViewModel.validateLoginForm()
                }
                .padding(.bottom, 24)

            SecureTextField(text: $loginViewModel.password, placeHolder: nil, title: NSLocalizedString("password", bundle: Bundle.main, comment: ""))
                .onReceive(loginViewModel.$password) { _ in
                    loginViewModel.validateLoginForm()
                }
                .padding(.bottom, 24)

            SolidRoundedButton(isEnabled: loginViewModel.isSubmitEnabled,
                               onClick: {
                                   if loginViewModel.checkLoginData() {
                                       loginViewModel.isNextViewActive = true
                                   } else {
                                       loginViewModel.isFormValid = false
                                   }
                               },
                               title: NSLocalizedString("btn_title_continue", bundle: Bundle.main, comment: ""))

            if !loginViewModel.isFormValid {
                ErrorMessage(message: loginViewModel.errorMessageLogin)
                    .padding(.top, 24)
            }
        })
        .onAppear {}
        .navigate(to: TwoFactorView(isActive: $loginViewModel.isNextViewActive).environmentObject(appState), when: $loginViewModel.isNextViewActive)
    }

    // MARK: Private
    @ObservedObject private var loginViewModel: LoginViewModel = .init()
}
