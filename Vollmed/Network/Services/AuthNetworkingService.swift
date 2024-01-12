//
//  AuthNetworkingService.swift
//  Vollmed
//
//  Created by Felipe Assis on 12/01/24.
//

import Foundation



protocol AuthServiceable {
    func logout() async -> Result<Bool?, RequestError>
}

struct AuthService: AuthServiceable {
    let client: HTTPClient = HTTPClientImpl()

    func logout() async -> Result<Bool?, RequestError> {
        return await client.sendRequest(endpoint: AuthEndpoint.logout, responseModel: nil)
    }
}
