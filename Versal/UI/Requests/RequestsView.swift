//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct RequestsView: View {
    // MARK: Internal
    var body: some View {
        NavigationView {
            ZStack {
                Text("requests")
            }
            .navigationTitle("requests")
            .navigationBarItems(trailing:
                Button(action: {}, label: {
                    Image(systemName: "ellipsis")
                }))
        }
    }

    // MARK: Private
    @ObservedObject private var requestsViewModel: RequestsViewModel = .init()
}

#Preview {
    RequestsView()
}
