//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Moya

extension MoyaProvider {
    class MoyaConcurrency {
        // MARK: Lifecycle
        init(provider: MoyaProvider) {
            self.provider = provider
        }

        // MARK: Internal
        func request<T: Decodable>(_ target: Target) async throws -> T {
            return try await withCheckedThrowingContinuation { continuation in
                provider.request(target) { result in
                    switch result {
                    case let .success(response):
                        guard (200 ... 299).contains(response.statusCode) else {
                            Log.breadcrumb("\(target.method.rawValue) \(target.path)")
                            Log.warn(MoyaError.statusCode(response))
                            continuation.resume(throwing: MoyaError.statusCode(response))
                            return
                        }
                        do {
                            let res = try JSONDecoder().decode(T.self, from: response.data)
                            continuation.resume(returning: res)
                        } catch {
                            continuation.resume(throwing: MoyaError.underlying(error, response))
                        }
                    case let .failure(error):
                        Log.breadcrumb("\(target.method.rawValue) \(target.path)")
                        Log.warn(error)
                        continuation.resume(throwing: error)
                    }
                }
            }
        }

        // MARK: Private
        private let provider: MoyaProvider
    }

    var async: MoyaConcurrency {
        MoyaConcurrency(provider: self)
    }
}
