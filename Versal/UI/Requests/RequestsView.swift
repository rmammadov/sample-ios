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
        BaseView(appState: appState,
                 content: {
                     VersalNavigationView(isBackAvailable: $isShowingDetail) {
                         ZStack {
                             BackgroundStyles.defaultBackground
                                 .ignoresSafeArea()
                         }
                     }
                 })
    }

    // MARK: Private
    @State private var isShowingDetail = false
    @ObservedObject private var requestsViewModel: RequestsViewModel = .init()
}

#Preview {
    RequestsView()
}
