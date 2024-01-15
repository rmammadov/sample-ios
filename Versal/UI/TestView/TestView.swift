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
            Button("btn_title") {
                print("\(TestViewModel.TAG) Button Tapped!")
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.primary500)
        }
        .padding()
    }

    // MARK: Private
    @StateObject private var testViewModel = TestViewModel()
}

#Preview {
    TestView()
}
