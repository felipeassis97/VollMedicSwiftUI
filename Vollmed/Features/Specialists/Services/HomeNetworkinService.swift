//
//  HomeNetworkinService.swift
//  Vollmed
//
//  Created by Felipe Assis on 12/01/24.
//

import Foundation


protocol HomeServiceable {
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError>
}


struct HomeNetworkinService: HomeServiceable {
    let client: HTTPClient = HTTPClientImpl()
    
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError> {
        return await client.sendRequest(endpoint: HomeEndpoint.getAllSpecialists, responseModel: [Specialist].self)
    }
}
