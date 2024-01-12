//
//  AuthEndpoint.swift
//  Vollmed
//
//  Created by Felipe Assis on 12/01/24.
//

import Foundation

enum AuthEndpoint {
    case logout
}

extension AuthEndpoint: Endpoint {
    var schema: String {
        return "http"
    }
    
    var path: String {
        switch self {
        case .logout:
            return "/auth/logout"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .logout:
            return .post
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .logout:
            guard let token = AuthManager.instance.token else {
                return nil
            }
            return [
                "Authorization" : "Bearer \(token)",
                "Content-Type" : "application/json"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .logout:
            return nil
        }
    }
}

