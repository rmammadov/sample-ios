//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct HomeView: View {
    // MARK: Internal
    @EnvironmentObject var appState: AppState

    var body: some View {
        BaseView(content: {
                     VersalNavigationView(isBackAvailable: $isShowingDetail) {
                         ZStack {
                             BackgroundStyles.defaultColor
                                 .ignoresSafeArea()
                         }
                     }
                     .onAppear { homeViewModel.listenAppLifecycle(appState: appState) }
                 },
                 contentViewModel: homeViewModel)
    }

    // MARK: Private
    @State private var isShowingDetail = false
    @StateObject private var homeViewModel: HomeViewModel = .init()
}

#Preview {
    HomeView()
}
