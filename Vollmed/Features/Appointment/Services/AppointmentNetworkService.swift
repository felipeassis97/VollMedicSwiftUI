//
//  AppointmentNetworkService.swift
//  Vollmed
//
//  Created by Felipe Assis on 14/01/24.
//

import Foundation

protocol AppointmentServiceable {
    func scheduleAppointment(specialistID: String, patientID: String, date: String) async -> Result<ScheduleAppointmentResponse?, RequestError>
    func reescheduleAppointment(appointmentID: String, newDate: String) async  -> Result<ScheduleAppointmentResponse?, RequestError>
    func cancelAppointment(appointmentID: String, reasonToCancel: String) async -> Result<Bool?, RequestError>
    func appointmentsByPatient(patientID: String) async -> Result<[Appointment]?, RequestError>
}

struct AppointmentService: AppointmentServiceable {
    let client: HTTPClient = HTTPClientImpl()

    func scheduleAppointment(specialistID: String, patientID: String, date: String) async -> Result<
        ScheduleAppointmentResponse?, RequestError> {
        return await client.sendRequest(endpoint: AppointmentEndpoint.scheduleAppointment(
            specialistID: specialistID,
            patientID: patientID,
            date: date), responseModel: ScheduleAppointmentResponse.self)
    }
    
    func reescheduleAppointment(appointmentID: String, newDate: String) async -> Result<
        ScheduleAppointmentResponse?, RequestError> {
        return await client.sendRequest(endpoint: AppointmentEndpoint.reescheduleAppointment(
            appointmentID: appointmentID, 
            newDate: newDate), responseModel: ScheduleAppointmentResponse.self)
    }
    
    func cancelAppointment(appointmentID: String, reasonToCancel: String) async -> Result<Bool?, RequestError> {
        return await client.sendRequest(endpoint: AppointmentEndpoint.cancelAppointment(
            appointmentID: appointmentID,
            reasonToCancel: reasonToCancel), responseModel: nil)
    }
    
    func appointmentsByPatient(patientID: String) async -> Result<
        [Appointment]?, RequestError> {
        return await client.sendRequest(endpoint: AppointmentEndpoint.appointmentsByPatient(
            patientID: patientID), responseModel: [Appointment].self)
    }
}
