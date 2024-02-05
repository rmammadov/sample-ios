//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct BaseView<Content: View>: View {
    // MARK: Lifecycle
    init(viewModel: BaseViewModel, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.viewModel = viewModel
    }

    // MARK: Internal
    let content: Content

    var body: some View {
        VStack {
            switch viewModel.state {
            case .presentContent:
                content
            case .presentPrivacyScreen:
                privacyView
            case .askForAuthentication:
                privacyView
                    .onAppear {
                        viewModel.updateAppState(viewState: .askForAuthentication)
                        privacyView.resign {
                            viewModel.updateAppState(viewState: .presentContent)
                        }
                    }
            }
        }
    }

    // MARK: Private
    private let privacyView = PrivacyView()

    @ObservedObject private var viewModel: BaseViewModel
}