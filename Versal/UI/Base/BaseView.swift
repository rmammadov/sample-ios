//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct BaseView<Content: View>: View {
    // MARK: Lifecycle

    init(viewModel: BaseViewModel = BaseViewModel(), @ViewBuilder content: () -> Content) {
        self.viewModel = viewModel
        self.content = content()
    }

    // MARK: Internal

    let content: Content

    var body: some View {
        // Add any common UI elements or modifiers here
        content
            .environmentObject(viewModel)
    }

    // MARK: Private
    @ObservedObject private var viewModel: BaseViewModel
}
