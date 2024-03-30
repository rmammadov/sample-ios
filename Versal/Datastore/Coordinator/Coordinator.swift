//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation
import Promises
import Then

public class Coordinator {
    // MARK: Lifecycle
    init() throws {
        self.db = DatabaseManager.instance()!
    }

    // MARK: Public
    public static func instance() -> Coordinator? {
        if singleton == nil {
            singleton = try? Coordinator()
        }
        return singleton
    }

    public func login(_ loginPayload: LoginPayload) async throws -> LoginPayload {
        reset()
        let loginPayload = try await service.login(loginPayload)
        return loginPayload
    }

    public func logout() async throws -> Bool {
        do {
            let result = try await service.logout()
            reset()
            return result
        } catch {
            throw LogoutError.logoutFailed
        }
    }

    public func verifyAccount(_ verifyAccountPayload: TwoFactorPayload) async throws -> TwoFactorPayload {
        reset()
        let verifyAccountPayload = try await service.verifyAccount(verifyAccountPayload)
        authenticated(verifyAccountPayload.token!, verifyAccountPayload.userId!)
        return verifyAccountPayload
    }

    public func reset() {
        service.setToken(nil)
        service.setAccountId(nil)
        UserDefaults.standard.reset()
        Keychain.reset()
        db.reset()
    }

    // MARK: Internal
    enum LogoutError: Error {
        case logoutFailed
    }

    // MARK: Private
    private static let semaphore = DispatchSemaphore(value: 1)
    private static var singleton: Coordinator?

    private let db: DatabaseManager
    private let service = VersalService()

    private func authenticated(_ token: UUID, _ accountId: UUID) {
        service.setToken(token)
        service.setAccountId(accountId)
        UserDefaults.standard.isUserLogedIn = true
    }
}
