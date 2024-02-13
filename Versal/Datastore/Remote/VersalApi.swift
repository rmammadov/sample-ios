//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

class VersalApi: ObservableObject {
    // MARK: Lifecycle
    private init() {
        switch EnvType.current {
        case .development:
            self.baseURL = URL(string: "https://dashboard.versal.money/")!
        case .sandbox:
            self.baseURL = URL(string: "https://sandbox.versal.money/")!
        case .production:
            self.baseURL = URL(string: "https://dev.versal.money/terms/")!
        }
    }

    // MARK: Internal
    static let shared = VersalApi()

    let baseURL: URL

    func getDpaUrl() -> URL {
        let path = "dpa/"

        return baseURL.appendingPathComponent(path)
    }

    func getPrivacyUrl() -> URL {
        let path = "privacy/"

        return baseURL.appendingPathComponent(path)
    }

    func getTermsUrl() -> URL {
        let path = "terms/"

        return baseURL.appendingPathComponent(path)
    }
}
