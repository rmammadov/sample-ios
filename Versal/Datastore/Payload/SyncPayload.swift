//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

public struct SyncPayload: Codable {
    // MARK: Lifecycle
    public init() {
        self.applicationVersion = VersalService.applicationVersion
        self.platformVersion = VersalService.platformVersion
    }

    // MARK: Public
    public var account: Int?
    public var allocationPercents: Int?
    public var allocations: Int?
    public var applicationVersion: String?
    public var charities: Int?
    public var depositAddresses: Int?
    public var family: Int?
    public var familyWallet: Int?
    public var faq: Int?
    public var instruments: Int?
    public var learn: Int?
    public var notifications: Int?
    public var platformVersion: String?
    public var prizes: Int?
    public var rewards: Int?
    public var syncId: UUID?
    public var trades: Int?
    public var transfers: Int?
}
