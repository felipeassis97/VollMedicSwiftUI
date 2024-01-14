//
//  HomeNetworkinService.swift
//  Vollmed
//
//  Created by Felipe Assis on 12/01/24.
//

import Foundation


protocol SpecialistsServiceable {
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError>
}


struct SpecialistsNetworkinService: SpecialistsServiceable {
    let client: HTTPClient = HTTPClientImpl()
    
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError> {
        return await client.sendRequest(endpoint: SpecialistsEndpoint.getAllSpecialists, responseModel: [Specialist].self)
    }
}
