//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct SplashView: View {
    // MARK: Internal
    @EnvironmentObject var appState: AppState

    var body: some View {
        if splashViewModel.isActive {
            ZStack {
                BackgroundStyles.defaultColor
                    .ignoresSafeArea()
                Image(R.image.logo_mark_gradient)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + SplashViewModel.splashDuration) {
                    withAnimation {
                        splashViewModel.isActive = false
                    }
                }
            }
        } else {
            if appState.isLoggedIn {
                MainView().environmentObject(appState)
            } else {
                LoginView().environmentObject(appState)
            }
        }
    }

    // MARK: Private
    @StateObject private var splashViewModel: SplashViewModel = .init()
}

#Preview {
    SplashView()
}
