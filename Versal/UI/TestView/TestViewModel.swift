//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

protocol TestViewModelProtocol {
    func checkIfPasscodeSet()
}

final class TestViewModel: ObservableObject, TestViewModelProtocol {
    // MARK: Internal
    static let TAG: String = "TEST_VIEW"

    @Published var isPasscodeViewPresenting = false
    @Published var isPasscodeSet = BiometricManager.shared.isPasscodeEnabled()
    @Published var isFaceIDSet = BiometricManager.shared.isFaceIDEnabled()
    @Published var isTouchIDSet = BiometricManager.shared.isTouchIDEnabled()

    var passcodePresentationMode: PasscodeMode = .verify

    func isFaceIDSupported() -> Bool {
        return BiometricManager.shared.isFaceIDSupported()
    }

    func isTouchIDSupported() -> Bool {
        return BiometricManager.shared.isTouchIDSupported()
    }

    func enableFaceID(yes: Bool) {
        BiometricManager.shared.verifyFaceID(verificationCompleted: { [self] success in
            if yes {
                BiometricManager.shared.setFaceIDEnabled(success)
            } else {
                BiometricManager.shared.setFaceIDEnabled(!success)
            }
            checkIfFaceIDSet()
        })
    }

    func enableTouchID(yes: Bool) {
        BiometricManager.shared.verifyTouchID(verificationCompleted: { [self] success in
            if yes {
                BiometricManager.shared.setTouchIDEnabled(success)
            } else {
                BiometricManager.shared.setTouchIDEnabled(!success)
            }
            checkIfTouchIDSet()
        })
    }

    func checkIfPasscodeSet() {
        isPasscodeSet = BiometricManager.shared.isPasscodeEnabled()
    }

    // MARK: Private
    private func checkIfFaceIDSet() {
        isFaceIDSet = BiometricManager.shared.isFaceIDEnabled()
    }

    private func checkIfTouchIDSet() {
        isTouchIDSet = BiometricManager.shared.isTouchIDEnabled()
    }
}
