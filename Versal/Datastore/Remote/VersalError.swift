//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

public struct VersalError: Codable, Error {
    // MARK: Lifecycle
    public init() {}

    public init(status: Int?) {
        self.status = status
    }

    // MARK: Public
    public struct Error: Codable, Hashable {
//        public var code: ErrorCode?
        public var message: String?
        public var parameter: String?
    }

    public var id: UUID?
    public var errors: [Error]?
    public var status: Int?
}
