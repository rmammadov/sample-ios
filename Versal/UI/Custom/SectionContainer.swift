//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct SectionContainer<Content: View, Footer: View>: View {
    // MARK: Lifecycle
    init(title: String, @ViewBuilder content: () -> Content, @ViewBuilder footer: () -> Footer) {
        self.content = content()
        self.title = title
        self.footer = footer()
    }

    // MARK: Internal

    // MARK: - Body
    var body: some View {
        ZStack {
            BackgroundStyles.defaultBackground
                .ignoresSafeArea()

            VStack {
                Spacer()

                VStack(alignment: .leading) {
                    SectionTitle(text: title)
                        .padding(.bottom, 24)

                    content
                }
                .padding(24)
                .background(.versalWhite)
                .overlay(RoundedRectangle(cornerRadius: 4)
                    .stroke(.versalGray100, lineWidth: 1))
                .padding(16)

                Spacer()

                footer
                    .padding(16)
            }
        }
    }

    // MARK: Private
    private let content: Content
    private let title: String
    private let footer: Footer?
}
