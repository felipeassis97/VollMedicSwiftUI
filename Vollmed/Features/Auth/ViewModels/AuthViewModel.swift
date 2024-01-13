//
//  AuthViewModel.swift
//  Vollmed
//
//  Created by Felipe Assis on 13/01/24.
//

import Foundation

struct AuthViewModel {
    
    // MARK: Atributes
    let auth: AuthServiceable
    let authManager = AuthManager.instance
    
    init(auth: AuthServiceable) {
        self.auth = auth
    }
    
    // MARK: Methods
    func signUp(cpf: String, name: String, email: String, password: String, 
                plan: String, phone: String) async -> Bool {
        
        let patient = Patient(id: nil, cpf: cpf, name: name, email: email, 
                              password: password, plan: plan, phone: phone)

        let result = await auth.signUp(patient: patient)
        switch result {
        case .success(let response):
            return response ?? false
        case .failure:
            return false
        }
    }
    
    func signIn(email: String, password: String) async -> Bool {
        let result = await auth.signIn(email: email, password: password)
        switch result {
        case .success(let response):
            if let response {
                authManager.saveToken(token: response.token)
                authManager.savePatientID(id: response.id)
                return true
            }
            return false
        case .failure(let error):
            print(error.localizedDescription)
            return false
        }
    }
    
    func signOut() async {
        let result =  await auth.signOut()
        switch result {
        case .success(_ ):
            authManager.removeToken()
            authManager.removePatientID()
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
