//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

public enum AuthenticationType {
    case faceID
    case noAuthentication
    case passcode
    case touchID
}

protocol PrivacyViewModelProtocol {
    func authenticated()
    func verifyAuthentication(_ authenticationCompleted: @escaping () -> Void)
}

final class PrivacyViewModel: ObservableObject, PrivacyViewModelProtocol {
    // MARK: Lifecycle
    init(authenticationType: AuthenticationType = .noAuthentication) {
        self.authenticationType = authenticationType
    }

    // MARK: Internal
    static let TAG = "PRIVACY_VIEW"

    @Published var authenticationType = AuthenticationType.noAuthentication

    func authenticated() {
        authenticationCompleted?()
        authenticationType = .noAuthentication
    }

    func verifyAuthentication(_ authenticationCompleted: @escaping () -> Void) {
        self.authenticationCompleted = authenticationCompleted

        if BiometricManager.shared.isFaceIDEnabled() {
            BiometricManager.shared.verifyFaceID { success in
                if success {
                    self.authenticated()
                }
            }
            authenticationType = .faceID
        } else if BiometricManager.shared.isTouchIDEnabled() {
            BiometricManager.shared.verifyTouchID { success in
                if success {
                    self.authenticated()
                }
            }
            authenticationType = .touchID
        } else if BiometricManager.shared.isPasscodeEnabled() {
            authenticationType = .passcode
        } else {
            authenticated()
        }
    }

    // MARK: Private
    private var authenticationCompleted: (() -> Void)?
}
