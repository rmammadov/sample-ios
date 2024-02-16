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
        BaseView(viewModel: mainViewModel, content: { // swiftlint:disable:this closure_body_length
            TabView { // swiftlint:disable:this closure_body_length
                NavigationView {
                    HomeView()
                        .navigationTitle("home")
                        .navigationBarItems(trailing:
                            Button(action: {}, label: {
                                Image(systemName: "plus")
                            }))
                }
                .tabItem {
                    Label("home", image: R.image.ic_home.name)
                }

                NavigationView {
                    RequestsView()
                        .navigationTitle("requests")
                        .navigationBarItems(trailing:
                            Button(action: {}, label: {
                                Image(systemName: "ellipsis")
                            }))
                }
                .tabItem {
                    Label("requests", image: R.image.ic_requests.name)
                }

                NavigationView {
                    TestView(appState: mainViewModel.appState)
                        .navigationTitle("settings")
                        .navigationBarItems(trailing:
                            Button(action: {}, label: {
                                Image(systemName: "gear")
                            }))
                }
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
