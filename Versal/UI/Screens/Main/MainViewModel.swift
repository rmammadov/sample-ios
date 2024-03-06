//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

protocol MainViewModelProtocol {}

class MainViewModel: BaseViewModel, MainViewModelProtocol {
    static let TAG: String = "MAIN_VIEW"

    @Published var selectedTab = 1
}
