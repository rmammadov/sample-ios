//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

public struct LoginPayload: Codable {
    // MARK: Lifecycle
    public init() {}

    public init(email: String, password: String) {
        self.email = email
        self.password = password
        self.applicationVersion = VersalService.applicationVersion
        self.platformType = VersalService.platformType
        self.platformVersion = VersalService.platformVersion
    }

    // MARK: Public
    public var applicationVersion: String?
    public var email: String?
    public var password: String?
    public var platformType: Platform?
    public var platformVersion: String?
    public var challenge: String?
}
