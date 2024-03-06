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
                     VersalNavigationView(isBackAvailable: $isShowingDetail) { // swiftlint:disable:this closure_body_length
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
                                     .listRowBackground(Color.versalWhite)

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
                                     .listRowBackground(Color.versalWhite)

                             Section {
                                 SolidRoundedButton(isEnabled: true,
                                                    onClick: {
                                                        settingsViewModel.isLogoutDialogPresenting.toggle()
                                                    },
                                                    title: "logout".localized())
                                     .alert(isPresented: $settingsViewModel.isLogoutDialogPresenting) {
                                         presentLogoutDialog()
                                     }
                             }
                             .listRowBackground(Color.versalWhite)
                             .listRowInsets(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: -20))
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
                     .onAppear { settingsViewModel.listenAppLifecycle(appState: appState) }
                 },
                 contentViewModel: settingsViewModel)
    }

    // MARK: Private
    @State private var isShowingDetail = false
    @StateObject private var settingsViewModel: SettingsViewModel = .init()
}

extension SettingsView {
    private func faceID(enable: Bool) {
        appState.setAuthentication(state: .authenticating)
        settingsViewModel.enableFaceID(yes: enable, enabilingFaceIDCompleted: {
            appState.setAuthentication(state: .authenticated)
        })
    }

    private func presentLogoutDialog() -> Alert {
        return Alert(title: Text("logout"),
                     message: Text("message_logout"),
                     primaryButton: .destructive(Text("logout")) {
                         logout()
                     },
                     secondaryButton: .cancel())
    }

    private func touchID(enable: Bool) {
        appState.setAuthentication(state: .authenticating)
        settingsViewModel.enableTouchID(yes: enable, enabilingTouchIDCompleted: {
            appState.setAuthentication(state: .authenticated)
        })
    }

    private func logout() {
        appState.logout()
    }
}

#Preview {
    SettingsView()
}