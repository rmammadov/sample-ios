//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct TestView: View {
    // MARK: Internal
    var body: some View {
        VStack {
            if #available(iOS 17.0, *) {
                Toggle("Enable Passcode", isOn: $testViewModel.isPasscodeSet)
                    .onChange(of: testViewModel.isPasscodeSet) { _, newValue in
                        if newValue {
                            testViewModel.passcodePresentationMode = .create
                            testViewModel.isPasscodeViewPresenting.toggle()
                        } else {
                            testViewModel.passcodePresentationMode = .remove
                            testViewModel.isPasscodeViewPresenting.toggle()
                        }
                    }
                    .padding()

                Toggle("Enable Face ID", isOn: $testViewModel.isFaceIDSet)
                    .disabled(!testViewModel.isFaceIDSupported())
                    .onChange(of: testViewModel.isFaceIDSet) { _, newValue in
                        testViewModel.enableFaceID(yes: newValue)
                    }
                    .padding()

                Toggle("Enable Touch ID", isOn: $testViewModel.isTouchIDSet)
                    .disabled(!testViewModel.isTouchIDSupported())
                    .onChange(of: testViewModel.isTouchIDSet) { _, newValue in
                        testViewModel.enableTouchID(yes: newValue)
                    }
                    .padding()
            }
        }
        .padding(48)
        .sheet(isPresented: $testViewModel.isPasscodeViewPresenting, content: {
            PasscodeView(mode: testViewModel.passcodePresentationMode, onPasscodeOperationCompleted: {
                testViewModel.isPasscodeViewPresenting.toggle()
                testViewModel.checkIfPasscodeSet()
            })
        })
    }

    // MARK: Private
    @StateObject private var testViewModel = TestViewModel()
}

#Preview {
    TestView()
}
