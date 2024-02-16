//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct LoginFormContainer<Content: View>: View {
    // MARK: Lifecycle
    init(title: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
    }

    // MARK: Internal
    var body: some View {
        ZStack { // swiftlint:disable:this closure_body_length
            Color.versalPrimary25
                .ignoresSafeArea()
            VStack { // swiftlint:disable:this closure_body_length
                Spacer()

                VStack(alignment: .leading) {
                    FormTitle(text: title)
                        .padding(.bottom, 24)

                    content
                }
                .padding(24)
                .background(.versalWhite)
                .overlay(RoundedRectangle(cornerRadius: 4)
                    .stroke(.versalGray100, lineWidth: 1))
                .padding(16)

                Spacer()

                VStack(alignment: .center, spacing: 8) {
                    Text("text_copyright")
                        .font(.system(size: 10))
                        .foregroundColor(.versalGray400)
                        .font(Font.headline.weight(.regular))
                        .padding()

                    HStack(spacing: 16) {
                        Link("title_terms", destination: VersalApi.shared.getTermsUrl())
                            .font(.system(size: 12))
                            .foregroundColor(.versalGray400)
                            .font(Font.headline.weight(.medium))

                        Circle()
                            .frame(width: 2, height: 2)
                            .foregroundColor(.versalGray400)

                        Link("title_privacy", destination: VersalApi.shared.getPrivacyUrl())
                            .font(.system(size: 12))
                            .foregroundColor(.versalGray400)
                            .font(Font.headline.weight(.medium))

                        Circle()
                            .frame(width: 2, height: 2)
                            .foregroundColor(.versalGray400)

                        Link("title_dpa", destination: VersalApi.shared.getDpaUrl())
                            .font(.system(size: 12))
                            .foregroundColor(.versalGray400)
                            .font(Font.headline.weight(.medium))
                    }
                }
            }
        }
    }

    // MARK: Private
    private let title: String
    private let content: Content
}
