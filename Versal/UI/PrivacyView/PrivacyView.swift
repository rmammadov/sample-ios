//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct PrivacyView: View {
    // MARK: Internal
    var body: some View {
        ZStack {
            Color.primary25
                .ignoresSafeArea()
            Image(ImageResource.logoMarkGradient)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
        }
        .onAppear {}
    }

    // MARK: Private
    @StateObject private var privacyViewModel = PrivacyViewModel()
}

extension PrivacyView {
    func resign(_: @escaping () -> Void) {}
}

#Preview {
    PrivacyView()
}
