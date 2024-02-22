//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct TopBar: View {
    @Binding var isBackAvailable: Bool

    let leadingButtonAction: (() -> Void)?
    let leadingButtonIcon: String?
    let title: String?
    let trailingButtonAction: (() -> Void)?
    let trailingButtonIcon: String?

    var body: some View {
        ZStack { // swiftlint:disable:this closure_body_length
            Rectangle()
                .foregroundColor(.versalNavigationWhite)
                .frame(height: 44)

            HStack { // swiftlint:disable:this closure_body_length
                if isBackAvailable {
                    BackButton(isBackAvailable: $isBackAvailable)
                } else if let leadingButtonAction = leadingButtonAction, let leadingButtonIcon = leadingButtonIcon {
                    Button(action: leadingButtonAction) {
                        Image(systemName: leadingButtonIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                    }
                    .padding(.leading, 12)
                }

                Spacer()

                HStack(alignment: .center) {
                    Image(R.image.logo_gradient_small)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .foregroundColor(.blue)

                    if let title = title {
                        Text(title)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.versalTitleTextBlack)
                            .padding(.leading, 8)
                    }
                }

                Spacer()

                if let trailingButtonAction = trailingButtonAction, let trailingButtonIcon = trailingButtonIcon {
                    Button(action: trailingButtonAction) {
                        Image(systemName: trailingButtonIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                    }
                    .padding(.trailing, 12)
                }
            }
            .frame(height: 44)
        }
    }
}
