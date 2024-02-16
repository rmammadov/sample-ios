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
        LoginFormContainer(title: "Sign In", content: {
            FormTextField(errorText: "Email is invalid", isNotValid: !loginViewModel.isEmailValid, placeHolder: "Email", title: "Email", text: $loginViewModel.email)
                .onReceive(loginViewModel.$email) { _ in
                    loginViewModel.validateLoginForm()
                }
                .padding(.bottom, 24)

            SecureTextField(placeHolder: "Password", title: "Password", text: $loginViewModel.password)
                .onReceive(loginViewModel.$password) { _ in
                    loginViewModel.validateLoginForm()
                }
                .padding(.bottom, 24)

            SolidRoundedButton(isEnabled: loginViewModel.isSubmitEnabled, title: "Continue", onClick: {
                if loginViewModel.checkLoginData() {
                    loginViewModel.isNextViewActive = true
                } else {
                    loginViewModel.isFormValid = false
                }
            })

            if !loginViewModel.isFormValid {
                ErrorMessage(message: "Email address and password entered does not match. Please try again.")
                    .padding(.top, 24)
            }
        })
        .onAppear {}
        .navigate(to: TwoFactorView(isActive: $loginViewModel.isNextViewActive).environmentObject(appState), when: $loginViewModel.isNextViewActive)
    }

    // MARK: Private
    @ObservedObject private var loginViewModel: LoginViewModel = .init()
}
