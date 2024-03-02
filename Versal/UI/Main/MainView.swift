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
        BaseView(appState: appState,
                 content: {
                     TabView {
                         HomeView()
                             .environmentObject(appState)
                             .tabItem {
                                 Label("home", image: R.image.ic_home.name)
                                     .padding(.bottom)
                             }

                         RequestsView()
                             .environmentObject(appState)
                             .tabItem {
                                 Label("requests", image: R.image.ic_requests.name)
                                     .padding(.bottom)
                             }

                         SettingsView()
                             .environmentObject(appState)
                             .tabItem {
                                 Label("settings", image: R.image.ic_settings.name)
                                     .padding(.bottom)
                             }
                     }
                     .accentColor(.versalPrimary500)
                 })
    }

    // MARK: Private
    @ObservedObject private var mainViewModel: MainViewModel = .init()
}

#Preview {
    MainView().environmentObject(AppState())
}
