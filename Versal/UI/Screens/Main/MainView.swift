//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct MainView: View {
    // MARK: Internal
    @EnvironmentObject var appState: AppState

    var body: some View {
        BaseView(content: {
                     TabView(selection: $mainViewModel.selectedTab) {
                         HomeView()
                             .environmentObject(appState)
                             .tabItem {
                                 Label("home", image: R.image.ic_home.name)
                                     .padding(.bottom)
                             }
                             .tag(1)

                         RequestsView()
                             .environmentObject(appState)
                             .tabItem {
                                 Label("requests", image: R.image.ic_requests.name)
                                     .padding(.bottom)
                             }
                             .tag(2)

                         SettingsView()
                             .environmentObject(appState)
                             .tabItem {
                                 Label("settings", image: R.image.ic_settings.name)
                                     .padding(.bottom)
                             }
                             .tag(3)
                     }
                     .accentColor(.versalPrimary500)
                     .onAppear { mainViewModel.listenAppLifecycle(appState: appState) }
                 },
                 contentViewModel: mainViewModel)
    }

    // MARK: Private
    @StateObject private var mainViewModel: MainViewModel = .init()
}

#Preview {
    MainView().environmentObject(AppState())
}
