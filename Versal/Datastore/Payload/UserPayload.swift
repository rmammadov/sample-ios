//
//  UserPayload.swift
//  Versal
//
//  Created by Rahman Mammadov on 02.04.24.
//

import Foundation

public struct UserFlagsPayload: Codable {
    public var otp: Bool?
    public var verified: Bool?
    public var workspaces: Bool?
}

public struct UserPayload: Codable {
    // MARK: Lifecycle
    public init(userId: UUID) {
        self.userId = userId
    }

    // MARK: Public
    public var object: String?
    public var created: Date?
    public var email: String?
    public var firstName: String?
    public var lastName: String?
    public var flags: UserFlagsPayload?
    public var updated: Date?
    public var userId: UUID?
}
