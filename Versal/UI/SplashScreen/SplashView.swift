//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct SplashView: View {
    // MARK: Internal
    var body: some View {
        ZStack {
            if splashViewModel.isActive {
                TestView()
            } else {
                Color.versalPrimary25
                    .ignoresSafeArea()
                Image(ImageResource.logoMarkGradient)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + SplashViewModel.splashDuration) {
                withAnimation {
                    splashViewModel.isActive = true
                }
            }
        }
    }

    // MARK: Private
    @StateObject private var splashViewModel = SplashViewModel()
}

#Preview {
    SplashView()
}
