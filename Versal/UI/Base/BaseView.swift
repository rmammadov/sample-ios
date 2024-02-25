//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct BaseView<Content: View>: View {
    // MARK: Lifecycle
    init(appState: AppState, @ViewBuilder content: () -> Content, swipeToDismiss: @escaping () -> Void = {}) {
        self.appState = appState
        self.content = content()
        self.swipeToDismiss = swipeToDismiss
    }

    // MARK: Internal
    var body: some View {
        VStack {
            switch appState.contentState {
            case .presentContent:
                content
            case .presentPrivacyScreen:
                privacyView
            case .askForAuthentication:
                privacyView
                    .onAppear {
                        privacyView.resign {
                            appState.setAuthentication(state: .authenticated)
                        }
                    }
            }
        }
        .gesture(swipeBackGesture())
    }

    // MARK: Private
    private let appState: AppState
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
