//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

enum ProgressDialogState {
    case hidden
    case inProgress
    case success
    case failure
}

class ProgressDialogViewModel: ObservableObject {
    @Published var progressState: ProgressDialogState?
    @Published var tryAgainButtonAction: (() -> Void)?

    func updateProgressState(_ newState: ProgressDialogState?) {
        Task { @MainActor in
            self.progressState = newState
        }
    }
}

struct ProgressDialog: View {
    // MARK: Lifecycle
    init(viewModel: ProgressDialogViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Internal
    var body: some View {
        VStack(spacing: 20) {
            if viewModel.progressState == .inProgress {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.versalPrimary500))
                    .scaleEffect(1.5)
                    .frame(width: 36, height: 36)
                TextStyles.subtitle(Text("loading".localized()))
            } else if viewModel.progressState == .success {
                Image(R.image.ic_success)
                    .resizable()
                    .foregroundColor(.green)
                    .frame(width: 36, height: 36)
                TextStyles.subtitle(Text("success".localized()))
            } else if viewModel.progressState == .failure {
                Image(R.image.ic_failed)
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 36, height: 36)
                TextStyles.subtitle(Text("failed".localized()))
                SolidRoundedButton(isEnabled: true, onClick: viewModel.tryAgainButtonAction ?? {}, title: "try_again".localized())
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(4)
        .shadow(radius: 2)
        .frame(width: 300)
    }

    // MARK: Private
    @ObservedObject private var viewModel: ProgressDialogViewModel
}
