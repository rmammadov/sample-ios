//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Moya
import SwiftUI

class VersalApi: ObservableObject {
    // MARK: Lifecycle
    private init() {
        switch EnvType.current {
        case .development:
            self.baseURL = URL(string: "https://dev.versal.money/")!
        case .sandbox:
            self.baseURL = URL(string: "https://sandbox.versal.money/")!
        case .production:
            self.baseURL = URL(string: "https://dashboard.versal.money/")!
        }
    }

    // MARK: Internal
    static let shared = VersalApi()

    let baseURL: URL

    func getDpaUrl() -> URL {
        return baseURL.appendingPathComponent("dpa/")
    }

    func getPrivacyUrl() -> URL {
        return baseURL.appendingPathComponent("privacy/")
    }

    func getTermsUrl() -> URL {
        return baseURL.appendingPathComponent("terms/")
    }
}

public enum VersalApiTarget {
    case login(LoginPayload)
    case logout
    case verify(TwoFactorPayload)
    case sync(SyncPayload)
}

extension VersalApiTarget: TargetType {
    public var baseURL: URL {
        return VersalApi.shared.baseURL
    }

    public var path: String {
        switch self {
        case .login:
            return "m/login/"
        case .logout:
            return "m/logout/"
        case .verify:
            return "m/verify/"
        case .sync:
            return "sync"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .logout: return .post
        case .login: return .post
        case .verify: return .post
        case .sync: return .post
        }
    }

    public var task: Task {
        switch self {
        case let .login(loginPayload): return .requestCustomJSONEncodable(loginPayload, encoder: JSON.encoder)
        case .logout: return .requestPlain
        case let .verify(twoFactorPayload): return .requestCustomJSONEncodable(twoFactorPayload, encoder: JSON.encoder)
        case let .sync(syncPayload): return .requestCustomJSONEncodable(syncPayload, encoder: JSON.encoder)
        }
    }

    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: Moya.ValidationType {
        return .successCodes
    }

    public var sampleData: Data {
        // Implement sample data for testing if necessary
        return Data()
    }
}
