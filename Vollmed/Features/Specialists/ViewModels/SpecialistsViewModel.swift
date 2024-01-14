//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Felipe Assis on 12/01/24.
//

import Foundation

struct SpecialistsViewModel {
    // MARK: Atributes
    let service: SpecialistsServiceable

    init(service: SpecialistsServiceable) {
        self.service = service
    }
    
    // MARK: Methods
    func getSpecialists() async throws -> [Specialist]?  {
        let result = try await service.getAllSpecialists()
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
