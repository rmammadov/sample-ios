//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct PasscodeView: View {
    // MARK: Lifecycle
    init(mode: PasscodeMode, onPasscodeOperationCompleted: @escaping () -> Void) {
        self.passcodeViewModel = .init(mode: mode, onPasscodeOperationCompleted: onPasscodeOperationCompleted)
    }

    // MARK: Internal
    var body: some View {
        VStack {
            Image(ImageResource.logoMarkGradient)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.bottom, 16)
            TextStyles.subtitle(getTitle())
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            PasscodeField(keyWasTyped: {}, maxDigits: passcodeViewModel.maxDigits, passcode: $passcodeViewModel.passcode)
                .padding(.bottom, 48)
                .shake($passcodeViewModel.isPasscodeFailed) {}
            KeyPadView(string: $passcodeViewModel.passcode, keyWasPressed: {
                passcodeViewModel.setup()
            })
        }
        .padding(48)
        .onAppear {}
    }

    // MARK: Private
    @ObservedObject private var passcodeViewModel: PasscodeViewModel
}

extension PasscodeView {
    private func getTitle() -> Text {
        switch passcodeViewModel.mode {
        case .create:
            return Text("title_create_passcode")
        case .confirm:
            return Text("title_confirm_passcode")
        case .remove:
            return Text("title_remove_passcode")
        default:
            return Text("title_verify_passcode")
        }
    }
}

#Preview {
    PasscodeView(mode: .create, onPasscodeOperationCompleted: {})
}
