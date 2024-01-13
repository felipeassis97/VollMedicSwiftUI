//
//  AuthNetworkingService.swift
//  Vollmed
//
//  Created by Felipe Assis on 12/01/24.
//

import Foundation



protocol AuthServiceable {
    func signOut() async -> Result<Bool?, RequestError>
    func signIn(email: String, password: String) async  -> Result<LoginResponse?, RequestError>
    func signUp(patient: Patient) async -> Result<Bool?, RequestError>
}

struct AuthService: AuthServiceable {
    let client: HTTPClient = HTTPClientImpl()

    func signUp(patient: Patient) async -> Result<Bool?, RequestError> {
        return await client.sendRequest(endpoint: AuthEndpoint.signUp(patient: patient), responseModel: nil)
    }
    
    func signIn(email: String, password: String) async -> Result<LoginResponse?, RequestError> {
        return await client.sendRequest(endpoint: AuthEndpoint.signIn(email: email, password: password), responseModel: LoginResponse.self)
    }
    
    func signOut() async -> Result<Bool?, RequestError> {
        return await client.sendRequest(endpoint: AuthEndpoint.signOut, responseModel: nil)
    }
}
