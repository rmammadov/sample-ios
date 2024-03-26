//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation
import Moya
import Then
import Promises

public class VersalService {
    init() { }
    
    public static let applicationVersion = Bundle.main.applicationVersion
    public static let platformType: Platform = UIDevice.current.userInterfaceIdiom == .pad ? .IOS_IPAD : .IOS_IPHONE
    public static let platformVersion = UIDevice.current.systemVersion
    
    
    public func login(_ loginPayload: LoginPayload) -> Promise<LoginPayload> {
        return Promise<LoginPayload> { self.processObject(.login(loginPayload), $0, $1) }
    }

    public func logout() -> Promise<Bool> {
        return Promise<Bool> { self.processBool(.logout, $0, $1) }
    }
    
    public func verifyAccount(_ verifyAccountPayload: TwoFactorPayload) -> Promise<TwoFactorPayload> {
        return Promise<TwoFactorPayload> { self.processObject(.verify(verifyAccountPayload), $0, $1) }
    }
    
    public func setAccountId(_ accountId: UUID?) {
        Keychain.set(.accountId, accountId?.uuidString)
    }

    public func setToken(_ token: String?) {
        Keychain.set(.token, token)
        Self.token = token
    }
    
    public func sync() -> Promise<SyncPayload> {
        return Promise { self.processObject(.sync(SyncPayload()), $0, $1) }
    }
    
    private let provider: MoyaProvider<VersalApiTarget>
    
    private func process(_ target: VersalApiTarget, _ success: @escaping (Moya.Response) throws -> Void, _ failure: @escaping Failure) {
        provider.request(target) { result in
            switch result {
            case let .success(container):
                do {
                    try success(container)
                } catch {
                    Log.breadcrumb("\(target.method.rawValue) \(target.path)")
                    Log.warn(error)
                    failure(VersalError(status: 0))
                }
            case let .failure(container):
                Log.breadcrumb("\(target.method.rawValue) \(target.path)")
                Log.warn(container)
                do {
                    if let response = container.response {
                        var error = try response.map(VersalError.self)
                        error.status = response.statusCode
                        failure(error)
                    } else {
                        failure(VersalError(status: container.response?.statusCode ?? 0))
                    }
                } catch {
                    failure(VersalError(status: container.response?.statusCode ?? 0))
                }
            }
        }
    }
    
    private func processBool(_ target: VersalApiTarget, _ success: @escaping Success<Bool>, _ failure: @escaping Failure) {
        process(target, { _ in success(true) }, failure)
    }
    
    private func processImage(_ target: VersalApiTarget, _ success: @escaping Success<UIImage>, _ failure: @escaping Failure) {
        process(target, { success(try $0.mapImage()) }, failure)
    }
    
    private func processObject<T: Decodable>(_ target: VersalApiTarget, _ success: @escaping Success<T>, _ failure: @escaping Failure) {
        process(target, { success(try $0.map(T.self, using: JSON.decoder, failsOnEmptyData: false)) }, failure)
    }
    
    // MARK: Internal
    typealias Failure = (_: VersalError) -> Void
    typealias Success<T> = (_: T) -> Void
    
    // MARK: Private
    private static var token: String? = Keychain.get(.token)
}
