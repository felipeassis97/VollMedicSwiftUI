//
//  AuthManager.swift
//  Vollmed
//
//  Created by Felipe Assis on 12/01/24.
//

import Foundation

//Singleton
class AuthManager: ObservableObject {
    static let instance = AuthManager()
    
    @Published var token: String? //@Published variável a ser monitorada
    @Published var patientID: String?
    
    private init() {
        self.token = KeychainHelper.get(for: AppKeys.userToken)
        self.patientID  = KeychainHelper.get(for: AppKeys.userID)
    }
    
    func saveToken(token: String) {
        KeychainHelper.save(value: token, key: AppKeys.userToken)
        self.token = token
    }
    
    func removeToken() {
        KeychainHelper.remove(for: AppKeys.userToken)
        self.token = nil
    }
    
    func savePatientID(id: String) {
        KeychainHelper.save(value: id, key: AppKeys.userID)
        self.patientID = id
    }
    
    func removePatientID() {
        KeychainHelper.remove(for: AppKeys.userID)
        self.patientID = nil
    }
    
}
