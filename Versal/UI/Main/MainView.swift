//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct MainView: View {
    // MARK: Lifecycle
    init(appState: AppState) {
        self.mainViewModel = .init(appState: appState)
    }

    // MARK: Internal
    var body: some View {
        BaseView(viewModel: mainViewModel, content: {
            TabView {
                HomeView()
                    .tabItem {
                        Label("home", image: R.image.ic_home.name)
                    }

                RequestsView()
                    .tabItem {
                        Label("requests", image: R.image.ic_requests.name)
                    }

                SettingsView()
                    .tabItem {
                        Label("settings", image: R.image.ic_settings.name)
                    }
            }
            .accentColor(.versalPrimary500)
        })
    }

    // MARK: Private
    @ObservedObject private var mainViewModel: MainViewModel
}

#Preview {
    MainView(appState: AppState())
}
