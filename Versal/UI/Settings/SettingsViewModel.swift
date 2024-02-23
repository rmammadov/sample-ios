//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

protocol SettingsViewModelProtocol {
    func checkIfFaceIDSet()
    func checkIfPasscodeSet()
    func checkIfTouchIDSet()
    func enableFaceID(yes: Bool, enabilingFaceIDCompleted: @escaping () -> Void)
    func enablePasscode(yes: Bool)
    func enableTouchID(yes: Bool, enabilingTouchIDCompleted: @escaping () -> Void)
    func isFaceIDSupported() -> Bool
    func isTouchIDSupported() -> Bool
    func getUserName() -> String
}

class SettingsViewModel: ObservableObject, SettingsViewModelProtocol {
    static let TAG: String = "SETTINGS_VIEW"

    @Published var isFaceIDSet = BiometricManager.shared.isFaceIDEnabled()
    @Published var isLogoutDialogPresenting = false
    @Published var isPasscodeSet = BiometricManager.shared.isPasscodeEnabled()
    @Published var isPasscodeViewPresenting = false
    @Published var isTouchIDSet = BiometricManager.shared.isTouchIDEnabled()

    var passcodePresentationMode: PasscodeMode = .verify

    internal func checkIfPasscodeSet() {
        isPasscodeSet = BiometricManager.shared.isPasscodeEnabled()
    }

    internal func checkIfFaceIDSet() {
        isFaceIDSet = BiometricManager.shared.isFaceIDEnabled()
    }

    internal func checkIfTouchIDSet() {
        isTouchIDSet = BiometricManager.shared.isTouchIDEnabled()
    }

    func enablePasscode(yes: Bool) {
        if yes {
            passcodePresentationMode = .create
            isPasscodeViewPresenting.toggle()
        } else {
            passcodePresentationMode = .remove
            isPasscodeViewPresenting.toggle()
        }
    }

    func enableFaceID(yes: Bool, enabilingFaceIDCompleted: @escaping () -> Void) {
        BiometricManager.shared.verifyFaceID(verificationCompleted: { [self] _ in
            BiometricManager.shared.setFaceIDEnabled(yes)
            enabilingFaceIDCompleted()
            checkIfFaceIDSet()
        })
    }

    func enableTouchID(yes: Bool, enabilingTouchIDCompleted: @escaping () -> Void) {
        BiometricManager.shared.verifyTouchID(verificationCompleted: { [self] _ in
            BiometricManager.shared.setTouchIDEnabled(yes)
            enabilingTouchIDCompleted()
            checkIfTouchIDSet()
        })
    }

    func isFaceIDSupported() -> Bool {
        return BiometricManager.shared.isFaceIDSupported()
    }

    func isTouchIDSupported() -> Bool {
        return BiometricManager.shared.isTouchIDSupported()
    }

    func getUserName() -> String {
        return "Rahman Mammadov"
    }
}
