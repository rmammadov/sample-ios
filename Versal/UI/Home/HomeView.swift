//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct HomeView: View {
    // MARK: Internal
    var body: some View {
        NavigationView {
            ZStack {
                Text("home")
            }
            .navigationTitle("home")
            .navigationBarItems(trailing:
                Button(action: {}, label: {
                    Image(systemName: "plus")
                }))
        }
    }

    // MARK: Private
    @ObservedObject private var homeViewModel: HomeViewModel = .init()
}

#Preview {
    HomeView()
}
