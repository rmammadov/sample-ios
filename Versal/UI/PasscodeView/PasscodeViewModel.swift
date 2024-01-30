//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

public enum PasscodeMode {
    case confirm
    case create
    case remove
    case verify
}

protocol PasscodeViewModelProtocol {
    func confirmPasscode()
    func createPasscode()
    func removePasscode()
    func setup()
    func verifyPasscode()
}

final class PasscodeViewModel: ObservableObject, PasscodeViewModelProtocol {
    // MARK: Lifecycle
    init(mode: PasscodeMode, onPasscodeOperationCompleted: @escaping () -> Void) {
        self.onPasscodeOperationCompleted = onPasscodeOperationCompleted
        self.mode = mode
        setup()
    }

    // MARK: Internal
    static let TAG: String = "PASSCODE_VIEW"

    @Published var isPasscodeFailed = false
    @Published var passcode = ""

    let maxDigits = 6
    var mode: PasscodeMode = .create

    func confirmPasscode() {
        if passcode.count == maxDigits {
            if temporaryPasscode == passcode {
                Keychain.set(.passcode, passcode)
                BiometricManager.shared.setPasscodeEnabled(true)
                onPasscodeOperationCompleted()
            } else {
                isPasscodeFailed.toggle()
            }
            passcode.removeAll()
        }
    }

    func createPasscode() {
        if passcode.count == maxDigits {
            temporaryPasscode = passcode
            passcode.removeAll()
            mode = .confirm
            confirmPasscode()
        }
    }

    func removePasscode() {
        if passcode.count == maxDigits {
            if passcode == Keychain.get(.passcode) {
                Keychain.reset()
                BiometricManager.shared.setPasscodeEnabled(false)
                onPasscodeOperationCompleted()
            } else {
                isPasscodeFailed.toggle()
            }
            passcode.removeAll()
        }
    }

    func setup() {
        switch mode {
        case .confirm:
            confirmPasscode()
        case .create:
            createPasscode()
        case .remove:
            removePasscode()
        default:
            verifyPasscode()
        }
    }

    func verifyPasscode() {
        if passcode.count == maxDigits {
            if passcode == Keychain.get(.passcode) {
                onPasscodeOperationCompleted()
            } else {
                isPasscodeFailed.toggle()
            }
            passcode.removeAll()
        }
    }

    // MARK: Private
    private var onPasscodeOperationCompleted: () -> Void

    private var temporaryPasscode = ""
}
