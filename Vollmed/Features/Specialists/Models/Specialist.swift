//
//  Specialist.swift
//  Vollmed
//
//  Created by Felipe Assis on 09/01/24.
//

import Foundation

struct Specialist: Identifiable, Codable {
    let id: String
    let name: String
    let crm: String
    let imageUrl: String
    let specialty: String
    let email: String
    let phoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "nome"
        case crm
        case imageUrl = "imagem"
        case specialty = "especialidade"
        case email
        case phoneNumber = "telefone"
    }
}

