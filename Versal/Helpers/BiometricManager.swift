//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import LocalAuthentication
import SwiftUI

private enum BiometricType {
    case face
    case optic
    case touch
    case unavailable
}

private let OFF: String? = nil
private let ON = "1" // swiftlint:disable:this identifier_name

public final class BiometricManager {
    // MARK: Lifecycle
    private init() {
        self.context = LAContext()
    }

    // MARK: Public
    public static let shared = BiometricManager()

    public func isFaceIDEnabled() -> Bool { return isFaceIDEnrolled() && Keychain.get(.faceIDEnabled) == ON }
    public func isOpticIDEnabled() -> Bool { return isOpticIDEnrolled() && Keychain.get(.opticIDEnabled) == ON }
    public func isPasscodeEnabled() -> Bool { return Keychain.get(.passcodeEnabled) == ON }
    public func isTouchIDEnabled() -> Bool { return isTouchIDEnrolled() && Keychain.get(.touchIDEnabled) == ON }

    public func isFaceIDEnrolled() -> Bool { return isFaceIDSupported() && isBiometrySupported(LABiometryType.faceID) }
    public func isOpticIDEnrolled() -> Bool { if #available(iOS 17, *) { return isOpticIDSupported() && isBiometrySupported(LABiometryType.opticID) } else { return false } }
    public func isTouchIDEnrolled() -> Bool { return isTouchIDSupported() && isBiometrySupported(LABiometryType.touchID) }

    public func isFaceIDSupported() -> Bool { return biometricType() == .face }
    public func isOpticIDSupported() -> Bool { return biometricType() == .optic }
    public func isTouchIDSupported() -> Bool { return biometricType() == .touch }

    public func setFaceIDEnabled(_ enabled: Bool) { Keychain.set(.faceIDEnabled, enabled ? ON : OFF) }
    public func setOpticIDEnabled(_ enabled: Bool) { Keychain.set(.opticIDEnabled, enabled ? ON : OFF) }
    public func setPasscodeEnabled(_ enabled: Bool) { Keychain.set(.passcodeEnabled, enabled ? ON : OFF) }
    public func setTouchIDEnabled(_ enabled: Bool) { Keychain.set(.touchIDEnabled, enabled ? ON : OFF) }

    public func verifyFaceID(verificationCompleted: @escaping (Bool) -> Void) {
        if isFaceIDEnrolled() {
            verifyBiometricAuthentication(completed: { success in
                verificationCompleted(success)
            })
        } else {
            verificationCompleted(false)
        }
    }

    public func verifyTouchID(verificationCompleted: @escaping (Bool) -> Void) {
        if isTouchIDEnrolled() {
            verifyBiometricAuthentication(completed: { success in
                verificationCompleted(success)
            })
        } else {
            verificationCompleted(false)
        }
    }

    // MARK: Private
    private var context: LAContext?

    private func biometricType() -> BiometricType {
        let authContext = LAContext()
        if #available(iOS 11, *) {
            _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            switch authContext.biometryType {
            case .none:
                return .unavailable
            case .touchID:
                return .touch
            case .faceID:
                return .face
            case .opticID:
                return .optic
            @unknown default:
                return .touch
            }
        } else {
            return authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touch : .unavailable
        }
    }

    private func isBiometrySupported(_ biometryType: LABiometryType) -> Bool {
        if context?.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ?? false {
            return context?.biometryType == biometryType
        }
        return false
    }

    private func verifyBiometricAuthentication(completed: @escaping (Bool) -> Void) {
        let reason = NSLocalizedString("text_identify_yourself", bundle: Bundle.main, comment: "")

        context?.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
            DispatchQueue.main.async {
                completed(success)
            }
        }
    }
}
