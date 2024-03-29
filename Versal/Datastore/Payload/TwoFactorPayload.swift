//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

public struct TwoFactorPayload: Codable {
    // MARK: Lifecycle
    public init(challenge: String?, otp: String?) {
        self.challenge = challenge
        self.otp = otp
    }

    // MARK: Public
    public var userId: String?
    public var challenge: String?
    public var otp: String?
    public var token: String?
}
