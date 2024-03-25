//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

class DialogViewModel: ObservableObject {
    @Published var dialogIcon: ImageResource?
    @Published var message: String?
    @Published var negativeButtonTitle: String?
    @Published var negativeButtonAction: (() -> Void)?
    @Published var positiveButtonTitle: String?
    @Published var positiveButtonAction: (() -> Void)?
    @Published var title: String?
}

struct CustomAlertDialog: View {
    // MARK: Lifecycle
    init(viewModel: DialogViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Internal
    var body: some View {
        VStack(alignment: .trailing, spacing: 16) { // swiftlint:disable:this closure_body_length
            Image(R.image.ic_cancel)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 24, height: 24)

            VStack(alignment: .leading, spacing: 20) {
                if let dialogIcon = viewModel.dialogIcon {
                    Image(dialogIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .padding()
                }

                if let title = viewModel.title {
                    TextStyles.dialogTitle(Text(title))
                }

                if let message = viewModel.message {
                    TextStyles.dialogBody(Text(message))
                }

                HStack(spacing: 16) {
                    if let negativeButtonTitle = viewModel.negativeButtonTitle {
                        TransparentRoundedButton(isEnabled: true, onClick: viewModel.negativeButtonAction ?? {}, title: negativeButtonTitle)
                    }
                    if let positiveButtonTitle = viewModel.positiveButtonTitle {
                        SolidRoundedButton(isEnabled: true, onClick: viewModel.positiveButtonAction ?? {}, title: positiveButtonTitle)
                    }
                }
            }
            .padding(20)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .shadow(radius: 2)
            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray, lineWidth: 2))
        }
        .padding(16)
    }

    // MARK: Private
    @ObservedObject private var viewModel: DialogViewModel
}
