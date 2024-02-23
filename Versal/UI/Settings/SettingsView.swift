//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct SettingsView: View {
    // MARK: Internal
    @EnvironmentObject var appState: AppState

    var body: some View {
        VersalNavigationView(isBackAvailable: $isShowingDetail,
                             title: NSLocalizedString("settings", bundle: Bundle.main, comment: "")) { // swiftlint:disable:this closure_body_length
            Form { // swiftlint:disable:this closure_body_length
                Section(header: Text("header_user_section")
                    .foregroundColor(.versalGray400)
                    .font(.system(size: 10))
                    .font(Font.headline.weight(.regular)),
                    content: {
                        HStack(alignment: .center) {
                            Image("yourImageName") // Replace "yourImageName" with the name of your image asset
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 42, height: 42)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2)) // Optional: add a border
                                .shadow(radius: 3)

                            VStack(alignment: .leading) {
                                Text(settingsViewModel.getUserName())
                                    .foregroundColor(.versalTextBlack)
                                    .font(.system(size: 14))
                                    .font(Font.headline.weight(.medium))

                                Text(settingsViewModel.getUserEmail())
                                    .foregroundColor(.versalGray400)
                                    .font(.system(size: 12))
                                    .font(Font.headline.weight(.regular))
                            }
                            .padding(.leading, 12)
                        }
                    })

                Section(header: Text("header_privacy_section")
                    .foregroundColor(.versalGray400)
                    .font(.system(size: 10))
                    .font(Font.headline.weight(.regular)),
                    content: { // swiftlint:disable:this closure_body_length
                        Toggle(isOn: $settingsViewModel.isPasscodeSet, label: {
                            Text("passcode")
                                .foregroundColor(.versalTextBlack)
                                .font(.system(size: 14))
                                .font(Font.headline.weight(.medium))
                        })
                        .onChange(of: settingsViewModel.isPasscodeSet) { newValue in
                            settingsViewModel.enablePasscode(yes: newValue)
                        }

                        if settingsViewModel.isFaceIDSupported() {
                            Toggle(isOn: $settingsViewModel.isFaceIDSet, label: {
                                Text("face_id")
                                    .foregroundColor(.versalTextBlack)
                                    .font(.system(size: 14))
                                    .font(Font.headline.weight(.medium))
                            })
                            .onChange(of: settingsViewModel.isFaceIDSet) { newValue in
                                faceID(enable: newValue)
                            }
                            .disabled(!settingsViewModel.isFaceIDEnrolled())
                        }

                        if settingsViewModel.isTouchIDSupported() {
                            Toggle(isOn: $settingsViewModel.isTouchIDSet, label: {
                                Text("touch_id")
                                    .foregroundColor(.versalTextBlack)
                                    .font(.system(size: 14))
                                    .font(Font.headline.weight(.medium))
                            })
                            .onChange(of: settingsViewModel.isTouchIDSet) { newValue in
                                touchID(enable: newValue)
                            }
                            .disabled(!settingsViewModel.isTouchIDEnrolled())
                        }
                    })

                Section {
                    SolidRoundedButton(isEnabled: true,
                                       onClick: {
                                           settingsViewModel.isLogoutDialogPresenting.toggle()
                                       },
                                       title: NSLocalizedString("logout", bundle: Bundle.main, comment: ""))
                        .alert(isPresented: $settingsViewModel.isLogoutDialogPresenting) {
                            presentLogoutDialog()
                        }
                }
            }
            .sheet(isPresented: $settingsViewModel.isPasscodeViewPresenting, content: {
                PasscodeView(mode: settingsViewModel.passcodePresentationMode, onPasscodeOperationCompleted: {
                    settingsViewModel.isPasscodeViewPresenting.toggle()
                    settingsViewModel.checkIfPasscodeSet()
                })
            })
        }
    }

    // MARK: Private
    @State private var isShowingDetail = false

    @ObservedObject private var settingsViewModel: SettingsViewModel = .init()
}

extension SettingsView {
    private func faceID(enable: Bool) {
        appState.updateAppState(viewState: .askForAuthentication)
        settingsViewModel.enableFaceID(yes: enable, enabilingFaceIDCompleted: {
            appState.updateAppState(viewState: .presentContent)
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
        appState.updateAppState(viewState: .askForAuthentication)
        settingsViewModel.enableTouchID(yes: enable, enabilingTouchIDCompleted: {
            appState.updateAppState(viewState: .presentContent)
        })
    }

    private func logout() {
        appState.logout()
    }
}

#Preview {
    SettingsView()
}
