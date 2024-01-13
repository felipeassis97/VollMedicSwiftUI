//
//  AuthEndpoint.swift
//  Vollmed
//
//  Created by Felipe Assis on 12/01/24.
//

import Foundation

enum AuthEndpoint {
    case signOut
    case signIn(email: String, password: String)
    case signUp(patient: Patient)
}

extension AuthEndpoint: Endpoint {
    var schema: String {
        return "http"
    }
    
    var path: String {
        switch self {
        case .signOut:
            return "/auth/logout"
        case .signIn:
            return "/auth/login"
        case .signUp:
            return "/paciente"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .signOut:
            return .post
        case .signIn:
            return .post
        case .signUp:
            return .post
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .signOut:
            guard let token = AuthManager.instance.token else {
                return nil
            }
            return [
                "Authorization" : "Bearer \(token)",
                "Content-Type" : "application/json"
            ]
            
        case .signIn:
            return nil
            
        case .signUp:
            return nil
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .signOut:
            return nil
            
        case .signIn(let email, let password):
            let body = ["email": email, "senha": password]
            return body
            
        case .signUp(let patient):
            return [
                "cpf": patient.cpf,
                "nome": patient.name,
                "email": patient.email,
                "senha": patient.password,
                "telefone": patient.phone,
                "planoSaude": patient.plan,
            ]
            
        }
    }
}

