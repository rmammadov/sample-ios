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
    static let TAG: String = "TEST_VIEW"

    @Published var isPasscodeViewPresenting = false
    @Published var isPasscodeSet = false

    var passcodePresentationMode: PasscodeMode = .verify

    func checkIfPasscodeSet() {
        isPasscodeSet = Keychain.get(.passcode) != nil
    }
}
