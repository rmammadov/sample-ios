//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct FooterContainer: View {
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            TextStyles.footerTitle(Text("text_copyright".localized(Date().currentYear())))
                .padding()

            HStack(spacing: 16) {
                TextStyles.footerLink(Link("title_terms", destination: VersalApi.shared.getTermsUrl()))

                Circle()
                    .frame(width: 2, height: 2)
                    .foregroundColor(.versalGray400)

                TextStyles.footerLink(Link("title_privacy", destination: VersalApi.shared.getPrivacyUrl()))

                Circle()
                    .frame(width: 2, height: 2)
                    .foregroundColor(.versalGray400)

                TextStyles.footerLink(Link("title_dpa", destination: VersalApi.shared.getDpaUrl()))
            }
        }
    }
}
