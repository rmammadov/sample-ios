//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct HeaderContainer: View {
    // MARK: Lifecycle
    init(isBackAvailable: Binding<Bool>,
         title: String? = nil,
         leadingButtonAction: (() -> Void)? = nil,
         leadingButtonIcon: String? = nil,
         trailingButtonAction: (() -> Void)? = nil,
         trailingButtonIcon: String? = nil) {
        self.leadingButtonAction = leadingButtonAction
        self.leadingButtonIcon = leadingButtonIcon
        self.title = title
        self.trailingButtonAction = trailingButtonAction
        self.trailingButtonIcon = trailingButtonIcon
        _isBackAvailable = isBackAvailable
    }

    // MARK: Internal
    @Binding var isBackAvailable: Bool

    var body: some View {
        ZStack { // swiftlint:disable:this closure_body_length
            BackgroundStyles.sidebarColor
                .frame(height: 44)

            HStack { // swiftlint:disable:this closure_body_length
                HStack {
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
                }.frame(width: 36)

                Spacer()

                HStack(alignment: .center) {
                    Image(R.image.logo_mark_gradient)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28, height: 28)
                        .foregroundColor(.blue)

                    if let title = title {
                        TextStyles.subtitle(Text(title))
                            .padding(.leading, 0)
                    }
                }

                Spacer()

                HStack {
                    if let trailingButtonAction = trailingButtonAction, let trailingButtonIcon = trailingButtonIcon {
                        Button(action: trailingButtonAction) {
                            Image(systemName: trailingButtonIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                        }
                        .padding(.trailing, 12)
                    }
                }.frame(width: 36)
            }
            .frame(height: 44)
        }
    }

    // MARK: Private
    private var leadingButtonAction: (() -> Void)?
    private var leadingButtonIcon: String?
    private var title: String?
    private var trailingButtonAction: (() -> Void)?
    private var trailingButtonIcon: String?
}
