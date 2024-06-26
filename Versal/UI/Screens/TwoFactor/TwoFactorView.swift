//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct TwoFactorView: View {
    // MARK: Lifecycle
    init(viewModel: TwoFactorViewModel, isActive: Binding<Bool>) {
        self._isActive = isActive
        self.twoFactorViewModel = viewModel
    }

    // MARK: Internal
    @EnvironmentObject var appState: AppState
    @Binding var isActive: Bool

    var body: some View {
        BaseView(content: {
                     VStack(spacing: 0) {
                         HeaderContainer(isBackAvailable: $isActive)

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
                                                                     submitVerification()
                                                                 },
                                                                 title: "btn_title_continue".localized())
                                          }, footer: { FooterContainer() })
                             .onAppear { twoFactorViewModel.listenAppLifecycle(appState: appState) }
                     }
                 },
                 contentViewModel: twoFactorViewModel,
                 swipeToDismiss: {
                     isActive = false
                 },
                 viewState: $twoFactorViewModel.viewState,
                 progressDialogViewModel: getProgressDialogViewModel())
    }

    // MARK: Private
    @ObservedObject private var twoFactorViewModel: TwoFactorViewModel
}

extension TwoFactorView {
    private func getProgressDialogViewModel() -> ProgressDialogViewModel {
        twoFactorViewModel.progressViewModel.tryAgainButtonAction = {
            submitVerification()
        }
        return twoFactorViewModel.progressViewModel
    }

    private func submitVerification() {
        Task { await twoFactorViewModel.submitVerification() }
    }
}
