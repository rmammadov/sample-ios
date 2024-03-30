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
                        guard let res = try? JSONDecoder.default.decode(T.self, from: response.data) else {
                            continuation.resume(throwing: MoyaError.jsonMapping(response))
                            return
                        }
                        continuation.resume(returning: res)
                    case let .failure(error):
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
