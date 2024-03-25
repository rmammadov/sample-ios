//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

enum CurrentViewState {
    case normal
    case progress
    case alert
}

struct BaseView<Content: View>: View {
    // MARK: Lifecycle
    init(@ViewBuilder content: () -> Content,
         contentViewModel: BaseViewModel,
         swipeToDismiss: @escaping () -> Void = {},
         viewState: Binding<CurrentViewState> = .constant(.normal),
         dialogViewModel: DialogViewModel? = nil,
         progressDialogViewModel: ProgressDialogViewModel? = nil) {
        self.content = content()
        self.dialogViewModel = dialogViewModel
        self.contentViewModel = contentViewModel
        self._viewState = viewState
        self.swipeToDismiss = swipeToDismiss
        self.progressDialogViewModel = progressDialogViewModel
    }

    // MARK: Internal
    var body: some View {
        ZStack { // swiftlint:disable:this closure_body_length
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

            if viewState != .normal {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            if viewState == .alert {
                                viewState = .normal
                            }
                        }
                    }

                Group {
                    if viewState == .alert {
                        if let dialogViewModel = dialogViewModel {
                            CustomAlertDialog(viewModel: dialogViewModel)
                        }
                    } else {
                        if let progressDialogViewModel = progressDialogViewModel {
                            ProgressDialog(viewModel: progressDialogViewModel)
                        }
                    }
                }
                .zIndex(1)
            }
        }
        .gesture(swipeBackGesture())
    }

    // MARK: Private
    @ObservedObject private var contentViewModel: BaseViewModel
    @Binding private var viewState: CurrentViewState

    private let content: Content
    private let dialogViewModel: DialogViewModel?
    private let privacyView = PrivacyView()
    private let progressDialogViewModel: ProgressDialogViewModel?
    private var swipeToDismiss: () -> Void

    private func swipeBackGesture() -> some Gesture {
        DragGesture().onEnded { gesture in
            if gesture.translation.width > 100 {
                swipeToDismiss()
            }
        }
    }
}
