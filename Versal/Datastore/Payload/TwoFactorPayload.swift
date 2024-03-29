//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

public struct TwoFactorPayload: Codable {
    // MARK: Lifecycle
    public init(accountId: UUID, challenge: String?, otp: String?) {
        self.accountId = accountId
        self.challenge = challenge
        self.otp = otp
    }

    // MARK: Public
    public var accountId: UUID?
    public var challenge: String?
    public var otp: String?
    public var token: String?
}