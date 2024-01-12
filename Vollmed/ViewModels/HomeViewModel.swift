//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Felipe Assis on 12/01/24.
//

import Foundation

struct HomeViewModel {
    // MARK: Atributes
    let service: HomeServiceable
    let auth: AuthServiceable
    let authManager = AuthManager.instance
    
    init(service: HomeServiceable, auth: AuthServiceable) {
        self.service = service
        self.auth = auth
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
    
    func logout() async {
        let result =  await auth.logout()
        switch result {
        case .success(_ ):
            authManager.removeToken()
            authManager.removePatientID()
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
