//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct HomeView: View {
    // MARK: Internal
    var body: some View {
        ZStack {
            Text("home")
        }
        .onAppear {}
    }

    // MARK: Private
    @ObservedObject private var homeViewModel: HomeViewModel = .init()
}

#Preview {
    HomeView()
}
