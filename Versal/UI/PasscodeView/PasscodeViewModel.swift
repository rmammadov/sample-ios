//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

public enum PasscodeMode {
    case create
    case confirm
    case remove
    case verify
}

protocol PasscodeViewModelProtocol {
    func setup()
    func createPasscode()
    func confirmPasscode()
    func removePasscode()
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

    @Published var passCode = ""
    @Published var isPasscodeFailed = false
    let maxDigits = 6

    var mode: PasscodeMode = .create

    func setup() {
        switch mode {
        case .create:
            createPasscode()
        case .confirm:
            confirmPasscode()
        case .remove:
            removePasscode()
        default:
            verifyPasscode()
        }
    }

    func createPasscode() {
        if passCode.count == maxDigits {
            temporary = passCode
            passCode.removeAll()
            mode = .confirm
            confirmPasscode()
        }
    }

    func confirmPasscode() {
        if passCode.count == maxDigits {
            if temporary == passCode {
                Keychain.set(.passcode, passCode)
                BiometricManager.shared.setPasscodeEnabled(true)
                onPasscodeOperationCompleted()
            } else {
                isPasscodeFailed.toggle()
            }
            passCode.removeAll()
        }
    }

    func removePasscode() {
        if passCode.count == maxDigits {
            if passCode == Keychain.get(.passcode) {
                Keychain.reset()
                BiometricManager.shared.setPasscodeEnabled(false)
                onPasscodeOperationCompleted()
            } else {
                isPasscodeFailed.toggle()
            }
            passCode.removeAll()
        }
    }

    func verifyPasscode() {
        if passCode.count == maxDigits {
            if passCode == Keychain.get(.passcode) {
                onPasscodeOperationCompleted()
            } else {
                isPasscodeFailed.toggle()
            }
            passCode.removeAll()
        }
    }

    // MARK: Private
    private var onPasscodeOperationCompleted: () -> Void

    private var temporary = ""
}
