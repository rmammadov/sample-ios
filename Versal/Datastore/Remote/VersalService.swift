//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation
import Moya
import Promises
import UIKit

public class VersalService {
    // MARK: Lifecycle
    init() {
        self.provider = MoyaProvider<VersalApiTarget>()
    }

    // MARK: Public
    public static let applicationVersion = Bundle.main.applicationVersion
    public static let platformType: Platform = UIDevice.current.userInterfaceIdiom == .pad ? .IOS_IPAD : .IOS_IPHONE
    public static let platformVersion = UIDevice.current.systemVersion

    public func logout() async throws -> Bool {
        return try await provider.async.request(.logout)
    }

    public func verifyAccount(_ verifyAccountPayload: TwoFactorPayload) async throws -> TwoFactorPayload {
        return try await provider.async.request(.verify(verifyAccountPayload))
    }

    public func setAccountId(_ accountId: String?) {
        Keychain.set(.accountId, accountId)
    }

    public func setToken(_ token: String?) {
        Keychain.set(.token, token)
        Self.token = token
    }

    public func sync() async throws -> SyncPayload {
        return try await provider.async.request(.sync(SyncPayload()))
    }

    // MARK: Internal
    typealias Failure = (_: VersalError) -> Void
    typealias Success<T> = (_: T) -> Void

    func login(_ loginPayload: LoginPayload) async throws -> LoginPayload {
        return try await provider.async.request(.login(loginPayload))
    }

    // MARK: Private
    private static var token: String? = Keychain.get(.token)

    private let provider: MoyaProvider<VersalApiTarget>
}
