//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation
import UIKit

public enum DeepLinkRequest {
    case resetPassword(_ accountId: UUID, _ challengeToken: Int) // "/reset-password/{UUID}/{long}/
    case verifyAccount(_ accountId: UUID, _ challengeToken: Int) // "/verify-account/{UUID}/{long}/
}

extension DeepLinkRequest {
    init?(_ components: URLComponents) { // swiftlint:disable:this cyclomatic_complexity
        var elements = components.path.components(separatedBy: "/")
        if elements.first != nil, elements.first!.isEmpty { elements = Array(elements.dropFirst()) }
        if elements.last != nil, elements.last!.isEmpty { elements = Array(elements.dropLast()) }
        var iterator = elements.makeIterator()
        switch (iterator.next(), iterator.next(), iterator.next()) {
        case let ("reset-password"?, parameter2?, parameter3?):
            guard let accountId = UUID(uuidString: parameter2), let challengeToken = Int(parameter3) else { return nil }
            self = .resetPassword(accountId, challengeToken)
        case let ("verify-account"?, parameter2?, parameter3?):
            guard let accountId = UUID(uuidString: parameter2), let challengeToken = Int(parameter3) else { return nil }
            self = .verifyAccount(accountId, challengeToken)
        default: return nil
        }
    }
}

public enum DeepLink {
    // MARK: Public
    public static func process() {
        guard let request = request else {
            return
        }
        Self.request = nil

        switch request {
        case let .resetPassword(accountId, challengeToken): Self.resetPassword(accountId, challengeToken)
        case let .verifyAccount(accountId, challengeToken): Self.verifyAccount(accountId, challengeToken)
        }
    }

    public static func process(_ request: DeepLinkRequest) {
        Self.request = request
        process()
    }

    public static func process(_ userActivity: NSUserActivity) {
        receive(userActivity)
        process()
    }

    public static func receive(_ userActivities: Set<NSUserActivity>) {
        if let userActivity = userActivities.first {
            receive(userActivity)
        }
    }

    public static func receive(_ userActivity: NSUserActivity) {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let incomingURL = userActivity.webpageURL,
              let components = URLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else {
            return
        }

        Self.request = DeepLinkRequest(components)
    }

    // MARK: Private
    private static var request: DeepLinkRequest?

    private static func resetPassword(_: UUID, _: Int) {
        if UserDefaults.standard.isUserLogedIn { return }
    }

    private static func verifyAccount(_: UUID, _: Int) {
        if UserDefaults.standard.isUserLogedIn { return }
    }
}
