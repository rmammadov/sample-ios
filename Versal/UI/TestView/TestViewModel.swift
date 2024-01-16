//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

protocol TestViewModelProtocol {}

final class TestViewModel: ObservableObject, TestViewModelProtocol {
    static let TAG: String = "TEST_VIEW"
}
