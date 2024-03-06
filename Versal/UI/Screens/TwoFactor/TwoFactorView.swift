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
        BaseView(content: {
                     SectionContainer(title: "title_two_factor".localized(),
                                      content: {
                                          CodeTextField(text: $twoFactorViewModel.code,
                                                        errorText: twoFactorViewModel.errorMessageCode,
                                                        isNotValid: !twoFactorViewModel.isFormValid,
                                                        maxLength: twoFactorViewModel.codeMaxLength,
                                                        minLength: twoFactorViewModel.codeMinLength,
                                                        placeHolder: "6_digit_code".localized(),
                                                        title: "title_enter_6_digit_code".localized())
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
                                                             title: "btn_title_continue".localized())
                                      }, footer: { FooterContainer() })
                         .onAppear { twoFactorViewModel.listenAppLifecycle(appState: appState) }
                 },
                 contentViewModel: twoFactorViewModel,
                 swipeToDismiss: {
                     isActive = false
                 })
    }

    // MARK: Private
    @StateObject private var twoFactorViewModel: TwoFactorViewModel = .init()
}