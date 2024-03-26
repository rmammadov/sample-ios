//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation
import Then
import Promises

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
    
    public func login(_ loginPayload: LoginPayload) -> Promise<LoginPayload> {
        return Promise { seal,<#arg#>  in
            async {
                do {
                    self.reset()
                    let loginPayload = try await self.service.login(loginPayload)
                    self.authenticated(loginPayload.token!, loginPayload.accountId!)
                    seal.fulfill(loginPayload)
                } catch {
                    seal.reject(error)
                }
            }
        }
    }

    public func logout() {
        return service.logout().retry(3).finally { self.reset() }
    }
    
    public func verifyAccount(_ verifyAccountPayload: TwoFactorPayload) -> Promise<TwoFactorPayload> {
        return async {
            self.reset()
            let verifyAccountPayload = try awaitPromise(self.service.verifyAccount(verifyAccountPayload))
            self.authenticated(verifyAccountPayload.token!, verifyAccountPayload.accountId!)
            return verifyAccountPayload
        }
    }
    
    public func reset() {
        service.setToken(nil)
        service.setAccountId(nil)
        UserDefaults.standard.reset()
        Keychain.reset()
        db.reset()
    }
    
    // MARK: Private
    private static let semaphore = DispatchSemaphore(value: 1)
    private static var singleton: Coordinator?
    private let db: DatabaseManager
    private let service = VersalService()
    
    private func authenticated(_ token: String, _ accountId: UUID) {
        service.setToken(token)
        service.setAccountId(accountId)
        UserDefaults.standard.isUserLogedIn = true
    }
}
