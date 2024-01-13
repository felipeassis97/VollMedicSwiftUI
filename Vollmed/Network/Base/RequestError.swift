//
//  RequestError.swift
//  Vollmed
//
//  Created by Felipe Assis on 12/01/24.
//

import Foundation


enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unknown
    case custom(_ error: [String: Any]?)
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Error when decode data"
        case .invalidURL:
            return "Error when create URL"
        case .noResponse:
            return "No response found"
        case .unauthorized:
            return "Invalid token"
        case .custom(let error):
            if let jsonError = error?["error"] as? [String: Any] {
                let message = jsonError["message"] as? String ?? ""
                return message
            }
            return "Ops! Ocorreu um erro ao carregar as informações."
        default:
            return "Unknown error"
        }
    }
    
}
