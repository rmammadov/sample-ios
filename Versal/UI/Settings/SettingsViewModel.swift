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
    func getUserEmail() -> String
    func getUserFirstName() -> String
    func getUserLastName() -> String
    func getUserName() -> String
    func isFaceIDEnrolled() -> Bool
    func isTouchIDEnrolled() -> Bool
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
            isPasscodeViewPresenting = true
        } else {
            passcodePresentationMode = .remove
            isPasscodeViewPresenting = true
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

    func getUserEmail() -> String {
        return "tester@versal.money"
    }

    func getUserFirstName() -> String {
        return "Rahman"
    }

    func getUserLastName() -> String {
        return "Mammadov"
    }

    func getUserName() -> String {
        return "\(getUserFirstName()) \(getUserLastName())"
    }

    func isPasscodeViewDissmised() {
        if isPasscodeViewPresenting { isPasscodeViewPresenting = false }
        checkIfPasscodeSet()
    }

    func isFaceIDEnrolled() -> Bool {
        return BiometricManager.shared.isFaceIDEnrolled()
    }

    func isFaceIDSupported() -> Bool {
        return BiometricManager.shared.isFaceIDSupported()
    }

    func isTouchIDEnrolled() -> Bool {
        return BiometricManager.shared.isTouchIDEnrolled()
    }

    func isTouchIDSupported() -> Bool {
        return BiometricManager.shared.isTouchIDSupported()
    }
}
