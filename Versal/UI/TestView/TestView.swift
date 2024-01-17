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
            Button("SET PASSCODE") {
                testViewModel.passcodePresentationMode = .create
                testViewModel.isPasscodeViewPresenting.toggle()
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.primary500)
            .controlSize(.large)
            .padding(.bottom, 16)
            .disabled(testViewModel.isPasscodeSet)

            Button("VERIFY PASSCODE") {
                testViewModel.passcodePresentationMode = .verify
                testViewModel.isPasscodeViewPresenting.toggle()
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.information500)
            .controlSize(.large)
            .padding(.bottom, 16)
            .disabled(!testViewModel.isPasscodeSet)

            Button("REMOVE PASSCODE") {
                testViewModel.passcodePresentationMode = .remove
                testViewModel.isPasscodeViewPresenting.toggle()
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.error500)
            .controlSize(.large)
            .padding(.bottom, 16)
            .disabled(!testViewModel.isPasscodeSet)
        }
        .padding(48)
        .sheet(isPresented: $testViewModel.isPasscodeViewPresenting, content: {
            PasscodeView(mode: testViewModel.passcodePresentationMode, onPasscodeOperationCompleted: {
                testViewModel.isPasscodeViewPresenting.toggle()
                testViewModel.checkIfPasscodeSet()
            })
        })
        .onAppear {
            testViewModel.checkIfPasscodeSet()
        }
    }

    // MARK: Private
    @StateObject private var testViewModel = TestViewModel()
}

#Preview {
    TestView()
}
