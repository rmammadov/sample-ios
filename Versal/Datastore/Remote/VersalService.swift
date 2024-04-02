//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation
import Moya

public class VersalService {
    // MARK: Lifecycle
    init() {
        self.provider = MoyaProvider<VersalApiTarget>()
    }

    // MARK: Public
    public static let applicationVersion = Bundle.main.applicationVersion
    public static let platformType: Platform = UIDevice.current.userInterfaceIdiom == .pad ? .IOS_IPAD : .IOS_IPHONE
    public static let platformVersion = UIDevice.current.systemVersion

    public func getAccount() async throws -> UserPayload {
        return try await provider.async.request(.getAccount)
    }
    
    public func getAccountId() -> UUID? {
        return UUID(uuidString: Keychain.get(.accountId) ?? "")
    }

    public func getAccountImage(_ accountId: UUID) async throws -> UIImage {
        return try await provider.async.requestImage(.getAccountImage(accountId))
    }
    
    public func login(_ loginPayload: LoginPayload) async throws -> LoginPayload {
        return try await provider.async.request(.login(loginPayload))
    }
    
    public func logout() async throws -> Bool {
        return try await provider.async.requestBool(.logout)
    }
    
    public func setAccountId(_ accountId: UUID?) {
        Keychain.set(.accountId, accountId?.uuidString)
    }

    public func setToken(_ token: UUID?) {
        Keychain.set(.token, token?.uuidString)
        Self.token = token?.uuidString
    }

    public func sync() async throws -> SyncPayload {
        return try await provider.async.request(.sync(SyncPayload()))
    }
    
    public func verifyAccount(_ verifyAccountPayload: TwoFactorPayload) async throws -> TwoFactorPayload {
        return try await provider.async.request(.verify(verifyAccountPayload))
    }

    // MARK: Private
    private static var token: String? = Keychain.get(.token)

    private let provider: MoyaProvider<VersalApiTarget>
}
