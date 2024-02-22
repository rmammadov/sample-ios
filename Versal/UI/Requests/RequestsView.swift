//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct RequestsView: View {
    // MARK: Internal
    var body: some View {
        VersalNavigationView(isBackAvailable: $isShowingDetail,
                             title: NSLocalizedString("requests", bundle: Bundle.main, comment: "")) {
            ZStack {}
        }
    }

    // MARK: Private
    @State private var isShowingDetail = false

    @ObservedObject private var requestsViewModel: RequestsViewModel = .init()
}

#Preview {
    RequestsView()
}
