//
//  Patient.swift
//  Vollmed
//
//  Created by Felipe Assis on 10/01/24.
//

import Foundation


struct Patient: Codable, Identifiable {
    let id: String?
    let cpf: String
    let name: String
    let email: String
    let password: String
    let plan: String
    let phone: String
    
    enum CodingKeys: String, CodingKey {
        case id, cpf, email
        case name = "nome"
        case plan = "planoSaude"
        case phone = "telefone"
        case password = "senha"
    }
}
