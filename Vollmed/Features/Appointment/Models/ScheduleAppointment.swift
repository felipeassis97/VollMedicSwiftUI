//
//  ScheduleAppointment.swift
//  Vollmed
//
//  Created by Felipe Assis on 10/01/24.
//

import Foundation

struct ScheduleAppointmentRequest: Codable {
    let specialistID: String
    let patientID: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case specialistID = "especialista"
        case patientID = "paciente"
        case date = "data"
    }
}

struct ScheduleAppointmentResponse: Codable, Identifiable {
    let id: String
    let specialistID: String
    let patientID: String
    let date: String
    let reasonToCancel: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case specialistID = "especialista"
        case patientID = "paciente"
        case date = "data"
        case reasonToCancel = "motivoCancelamento"
    }
}
