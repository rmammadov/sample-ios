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
            if privacyViewModel.authenticationType == .passcode {
                PasscodeView(mode: .verify, onPasscodeOperationCompleted: {
                    privacyViewModel.authenticated()
                })
            } else {
                BackgroundStyles.defaultColor
                    .ignoresSafeArea()
                Image(R.image.logo_mark_gradient)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
        }
        .onAppear {}
    }

    // MARK: Private
    @ObservedObject private var privacyViewModel: PrivacyViewModel = .init()
}

extension PrivacyView {
    func resign(_ completion: @escaping () -> Void) {
        privacyViewModel.verifyAuthentication(completion)
    }
}

#Preview {
    PrivacyView()
}
