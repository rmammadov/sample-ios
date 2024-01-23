//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation
import LocalAuthentication

private let OFF: String? = nil
private let ON = "1" // swiftlint:disable:this identifier_name

public final class BiometricManager {
    // MARK: Lifecycle
    private init() {
        self.context = LAContext()
    }

    // MARK: Public
    public static let shared = BiometricManager()

    public func isFaceIDEnabled() -> Bool { return Keychain.get(.faceIDEnabled) == ON }
    public func isPasscodeEnabled() -> Bool { return Keychain.get(.passcodeEnabled) == ON }
    public func isTouchIDEnabled() -> Bool { return Keychain.get(.touchIDEnabled) == ON }

    public func isFaceIDSupported() -> Bool { return isBiometrySupported(LABiometryType.faceID) }
    public func isTouchIDSupported() -> Bool { return isBiometrySupported(LABiometryType.touchID) }

    public func setFaceIDEnabled(_ enabled: Bool) { Keychain.set(.faceIDEnabled, enabled ? ON : OFF) }
    public func setPasscodeEnabled(_ enabled: Bool) { Keychain.set(.passcodeEnabled, enabled ? ON : OFF) }
    public func setTouchIDEnabled(_ enabled: Bool) { Keychain.set(.touchIDEnabled, enabled ? ON : OFF) }

    public func verifyFaceID(verificationCompleted: @escaping (Bool) -> Void) {
        if isFaceIDSupported() {
            verifyBiometricAuthentication(completed: { success in
                verificationCompleted(success)
            })
        } else {
            verificationCompleted(false)
        }
    }

    public func verifyTouchID(verificationCompleted: @escaping (Bool) -> Void) {
        if isTouchIDSupported() {
            verifyBiometricAuthentication(completed: { success in
                verificationCompleted(success)
            })
        } else {
            verificationCompleted(false)
        }
    }

    // MARK: Private
    private var context: LAContext?

    private func isBiometrySupported(_ biometryType: LABiometryType) -> Bool {
        if context?.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ?? false {
            return context?.biometryType == biometryType
        }
        return false
    }

    private func verifyBiometricAuthentication(completed: @escaping (Bool) -> Void) {
        let reason = "text_identify_yourself"

        context?.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
            DispatchQueue.main.async {
                completed(success)
            }
        }
    }
}
