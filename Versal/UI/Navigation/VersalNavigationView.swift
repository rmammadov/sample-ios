//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct VersalNavigationView<Content: View>: View {
    // MARK: Lifecycle
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    // MARK: Internal
    let content: Content

    var body: some View {
        NavigationView {
            content
        }
    }
}
