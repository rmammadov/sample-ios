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
        if loginViewModel.isTwoFactorVerificationRequested {
            TwoFactorView(isActive: $loginViewModel.isTwoFactorVerificationRequested)
        } else {
            BaseView(content: { // swiftlint:disable:this closure_body_length
                         VStack(spacing: 0) {
                             HeaderContainer()

                             SectionContainer(title: "title_sign_in".localized(),
                                              content: {
                                                  PlainTextField(text: $loginViewModel.email,
                                                                 autoCapitalizationType: nil,
                                                                 errorText: loginViewModel.errorMessageEmail,
                                                                 isNotValid: !loginViewModel.isEmailValid,
                                                                 keyboardType: .emailAddress,
                                                                 placeHolder: nil,
                                                                 title: "email".localized())
                                                      .onReceive(loginViewModel.$email) { _ in
                                                          loginViewModel.didContentHasChanged()
                                                      }
                                                      .padding(.bottom, 24)

                                                  SecureTextField(text: $loginViewModel.password, placeHolder: nil, title: "password".localized())
                                                      .onReceive(loginViewModel.$password) { _ in
                                                          loginViewModel.didContentHasChanged()
                                                      }
                                                      .padding(.bottom, 24)

                                                  SolidRoundedButton(isEnabled: loginViewModel.isSubmitEnabled,
                                                                     onClick: {
                                                                         loginViewModel.validateLoginForm()
                                                                     },
                                                                     title: "btn_title_continue".localized())

                                                  if !loginViewModel.isFormValid {
                                                      ErrorMessage(message: loginViewModel.errorMessageLogin)
                                                          .padding(.top, 24)
                                                  }
                                              }, footer: { FooterContainer() })
                                 .onAppear { loginViewModel.listenAppLifecycle(appState: appState) }
                         }
                     },
                     contentViewModel: loginViewModel)
        }
    }

    // MARK: Private
    @StateObject private var loginViewModel: LoginViewModel = .init()
}
