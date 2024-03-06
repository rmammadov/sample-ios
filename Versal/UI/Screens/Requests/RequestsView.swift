//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct RequestsView: View {
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
                     .onAppear { requestsViewModel.listenAppLifecycle(appState: appState) }
                 },
                 contentViewModel: requestsViewModel)
    }

    // MARK: Private
    @State private var isShowingDetail = false
    @StateObject private var requestsViewModel: RequestsViewModel = .init()
}

#Preview {
    RequestsView()
}
