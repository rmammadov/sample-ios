//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct SettingsView: View {
    // MARK: Internal
    var body: some View {
        ZStack {
            Text("settings")
        }
        .onAppear {}
    }

    // MARK: Private
    @ObservedObject private var settingsViewModel: SettingsViewModel = .init()
}

#Preview {
    SettingsView()
}
