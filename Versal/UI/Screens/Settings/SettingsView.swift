//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct SettingsView: View {
    // MARK: Lifecycle
    init() {
        UITableView.appearance().backgroundColor = .clear
    }

    // MARK: Internal
    @EnvironmentObject var appState: AppState

    var body: some View {
        BaseView(content: { // swiftlint:disable:this closure_body_length
                     VersalNavigationView { // swiftlint:disable:this closure_body_length
                         ZStack { // swiftlint:disable:this closure_body_length
                             BackgroundStyles.defaultColor
                                 .ignoresSafeArea()

                             VStack(spacing: 0) { // swiftlint:disable:this closure_body_length
                                 HeaderContainer()

                                 Form { // swiftlint:disable:this closure_body_length
                                     Section(header: TextStyles.settingsSectionHeader(Text("header_user_section")),
                                             content: {
                                                 HStack(alignment: .center) {
                                                     UserInitialsView(firstName: settingsViewModel.getUserFirstName(), lastName: settingsViewModel.getUserLastName())

                                                     VStack(alignment: .leading) {
                                                         TextStyles.settingsUserDetailsName(Text(settingsViewModel.getUserName()))
                                                             .frame(height: 20)

                                                         TextStyles.settingsUserDetailsEmail(Text(settingsViewModel.getUserEmail()))
                                                             .frame(height: 16)
                                                     }
                                                     .padding(.leading, 10)
                                                 }
                                             })
                                             .listRowBackground(ElementStyles.backgroundColor)

                                     Section(header: TextStyles.settingsSectionHeader(Text("header_privacy_section")),
                                             content: {
                                                 Toggle(isOn: $settingsViewModel.isPasscodeSet, label: {
                                                     TextStyles.settingsItemTitle(Text("passcode"))
                                                 })
                                                 .onChange(of: settingsViewModel.isPasscodeSet) { newValue in
                                                     settingsViewModel.enablePasscode(yes: newValue)
                                                 }

                                                 if settingsViewModel.isFaceIDSupported() {
                                                     Toggle(isOn: $settingsViewModel.isFaceIDSet, label: {
                                                         TextStyles.settingsItemTitle(Text("face_id"))
                                                     })
                                                     .onChange(of: settingsViewModel.isFaceIDSet) { newValue in
                                                         faceID(enable: newValue)
                                                     }
                                                     .disabled(!settingsViewModel.isFaceIDEnrolled())
                                                 }

                                                 if settingsViewModel.isTouchIDSupported() {
                                                     Toggle(isOn: $settingsViewModel.isTouchIDSet, label: {
                                                         TextStyles.settingsItemTitle(Text("touch_id"))
                                                     })
                                                     .onChange(of: settingsViewModel.isTouchIDSet) { newValue in
                                                         touchID(enable: newValue)
                                                     }
                                                     .disabled(!settingsViewModel.isTouchIDEnrolled())
                                                 }
                                             })
                                             .listRowBackground(BackgroundStyles.defaultColor)
                                             .listRowSeparator(.hidden)

                                     Section {
                                         VStack(alignment: .leading) {
                                             Divider()
                                                 .overlay(ElementStyles.dividerColor)

                                             IconLabelButton(image: R.image.ic_logout,
                                                             isEnabled: true,
                                                             onClick: {
                                                                 settingsViewModel.viewState = .alert
                                                             },
                                                             title: "logout".localized())
                                         }
                                     }
                                     .listRowBackground(BackgroundStyles.defaultColor)
                                     .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                 }
                                 .background(BackgroundStyles.defaultColor.ignoresSafeArea())
                                 .modifier(FormHiddenBackgroundModifier())
                                 .sheet(isPresented: $settingsViewModel.isPasscodeViewPresenting, content: {
                                     PasscodeView(mode: settingsViewModel.passcodePresentationMode, onPasscodeOperationCompleted: {
                                         settingsViewModel.isPasscodeViewDissmised()
                                     })
                                 })
                                 .onChange(of: settingsViewModel.isPasscodeViewPresenting) { isPresenting in
                                     if !isPresenting {
                                         settingsViewModel.isPasscodeViewDissmised()
                                     }
                                 }
                             }
                         }
                     }
                     .onAppear { settingsViewModel.listenAppLifecycle(appState: appState) }
                 },
                 contentViewModel: settingsViewModel,
                 viewState: $settingsViewModel.viewState,
                 dialogViewModel: getLogoutDialogViewModel(),
                 progressDialogViewModel: getProgressDialogViewModel())
    }

    // MARK: Private
    @State private var isShowingDetail = false
    @StateObject private var settingsViewModel: SettingsViewModel = .init()
}

extension SettingsView {
    private func faceID(enable: Bool) {
        appState.setAuthentication(state: .authenticating)
        settingsViewModel.enableFaceID(yes: enable, enablingFaceIDCompleted: {
            appState.setAuthentication(state: .authenticated)
        })
    }

    func getProgressDialogViewModel() -> ProgressDialogViewModel {
        settingsViewModel.progressViewModel.tryAgainButtonAction = { logout() }
        return settingsViewModel.progressViewModel
    }

    func getLogoutDialogViewModel() -> DialogViewModel {
        settingsViewModel.dialogViewModel.title = "logout".localized()
        settingsViewModel.dialogViewModel.message = "message_logout".localized()
        settingsViewModel.dialogViewModel.negativeButtonTitle = "cancel".localized()
        settingsViewModel.dialogViewModel.negativeButtonAction = { settingsViewModel.viewState = .normal }
        settingsViewModel.dialogViewModel.positiveButtonTitle = "logout".localized()
        settingsViewModel.dialogViewModel.positiveButtonAction = { logout() }
        return settingsViewModel.dialogViewModel
    }

    private func touchID(enable: Bool) {
        appState.setAuthentication(state: .authenticating)
        settingsViewModel.enableTouchID(yes: enable, enablingTouchIDCompleted: {
            appState.setAuthentication(state: .authenticated)
        })
    }

    private func logout() {
        Task { await settingsViewModel.logout() }
    }
}

#Preview {
    SettingsView()
}
