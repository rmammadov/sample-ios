//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

protocol SplashViewModelProtocol {}

class SplashViewModel: BaseViewModel, SplashViewModelProtocol {
    static let TAG = "SPLASH_VIEW"

    static let splashDuration = 2.5

    @Published var isActive = true
}
