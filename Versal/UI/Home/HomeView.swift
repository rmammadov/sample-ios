//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct HomeView: View {
    // MARK: Internal
    var body: some View {
        VersalNavigationView(isBackAvailable: $isShowingDetail,
                             title: NSLocalizedString("home", bundle: Bundle.main, comment: "")) {
            ZStack {}
        }
    }

    // MARK: Private
    @State private var isShowingDetail = true

    @ObservedObject private var homeViewModel: HomeViewModel = .init()
}

#Preview {
    HomeView()
}
