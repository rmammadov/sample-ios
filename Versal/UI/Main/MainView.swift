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
                NavigationView {
                    HomeView()
                        .navigationTitle("home")
                        .navigationBarItems(trailing:
                            Button(action: {}) {
                                Image(systemName: "plus")
                            })
                }
                .tabItem {
                    Label("home", image: "ic_home_draft")
                }

                NavigationView {
                    RequestsView()
                        .navigationTitle("requests")
                        .navigationBarItems(trailing:
                            Button(action: {}) {
                                Image(systemName: "ellipsis")
                            })
                }
                .tabItem {
                    Label("requests", image: "ic_requests_draft")
                }

                NavigationView {
                    TestView(appState: mainViewModel.appState)
                        .navigationTitle("settings")
                        .navigationBarItems(trailing:
                            Button(action: {}) {
                                Image(systemName: "gear")
                            })
                }
                .tabItem {
                    Label("settings", image: "ic_settings_draft")
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
