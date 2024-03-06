//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct BaseView<Content: View>: View {
    // MARK: Lifecycle
    init(@ViewBuilder content: () -> Content, contentViewModel: BaseViewModel, swipeToDismiss: @escaping () -> Void = {}) {
        self.content = content()
        self.contentViewModel = contentViewModel
        self.swipeToDismiss = swipeToDismiss
    }

    // MARK: Internal
    var body: some View {
        ZStack {
            BackgroundStyles.sidebarColor
                .ignoresSafeArea()

            switch contentViewModel.appState?.contentState {
            case .presentContent:
                content
            case .presentPrivacyScreen:
                privacyView
            case .askForAuthentication:
                privacyView
                    .onAppear {
                        privacyView.resign {
                            contentViewModel.appState?.setAuthentication(state: .authenticated)
                        }
                    }
            case .none:
                content
            }
        }
        .gesture(swipeBackGesture())
    }

    // MARK: Private
    @ObservedObject private var contentViewModel: BaseViewModel

    private let content: Content
    private let privacyView = PrivacyView()
    private var swipeToDismiss: () -> Void

    private func swipeBackGesture() -> some Gesture {
        DragGesture().onEnded { gesture in
            if gesture.translation.width > 100 {
                swipeToDismiss()
            }
        }
    }
}
