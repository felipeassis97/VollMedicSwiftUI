//
//  AppointmentEndpoint.swift
//  Vollmed
//
//  Created by Felipe Assis on 14/01/24.
//

import Foundation

enum AppointmentEndpoint {
    case scheduleAppointment(specialistID: String, patientID: String, date: String)
    case reescheduleAppointment(appointmentID: String, newDate: String)
    case cancelAppointment(appointmentID: String, reasonToCancel: String)
    case appointmentsByPatient(patientID: String)
}


extension AppointmentEndpoint: Endpoint {
    var schema: String {
        return "http"
    }
    
    var path: String {
        switch self {
        case .scheduleAppointment:
            return "/consulta"
        case .reescheduleAppointment(let appointmentID, _):
            return "/consulta/" + appointmentID
        case .cancelAppointment(let appointmentID, _):
            return "/consulta/" + appointmentID
        case .appointmentsByPatient(let patientID):
            return "/paciente/" + patientID + "/consultas"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .scheduleAppointment:
            return .post
        case .reescheduleAppointment:
            return .path    
        case .cancelAppointment:
            return .delete
        case .appointmentsByPatient:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .scheduleAppointment:
            guard let token = AuthManager.instance.token else {
                return nil
            }
            return [
                "Authorization" : "Bearer \(token)",
                "Content-Type" : "application/json"
            ]
        case .reescheduleAppointment:
            guard let token = AuthManager.instance.token else {
                return nil
            }
            return [
                "Authorization" : "Bearer \(token)",
                "Content-Type" : "application/json"
            ]
        case .cancelAppointment:
            guard let token = AuthManager.instance.token else {
                return nil
            }
            return [
                "Authorization" : "Bearer \(token)",
                "Content-Type" : "application/json"
            ]
        case .appointmentsByPatient:
            guard let token = AuthManager.instance.token else {
                return nil
            }
            return [
                "Authorization" : "Bearer \(token)",
                "Content-Type" : "application/json"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .scheduleAppointment(let specialistID, let patientID, let date):
            return [
                "especialista": specialistID,
                "paciente": patientID,
                "data": date
            ]
        case .reescheduleAppointment(_, let date):
            return [
                "data": date
            ]
        case .cancelAppointment(_, let reasonToCancel):
            return [
                "motivo_cancelamento": reasonToCancel
            ]
        case .appointmentsByPatient:
            return nil
        }
    }
}
