//
//  AppointmentViewModel.swift
//  Vollmed
//
//  Created by Felipe Assis on 14/01/24.
//

import Foundation

struct AppointmentsViewModel {
    // MARK: Atributes
    let service: AppointmentServiceable

    init(service: AppointmentServiceable) {
        self.service = service
    }
    
    // MARK: Methods
    func scheduleAppointment(specialistID: String, patientID: String, date: String) async throws -> ScheduleAppointmentResponse? {
        let result = await service.scheduleAppointment(specialistID: specialistID, patientID: patientID, date: date)
        switch result {
        case .success(let schedule):
            return schedule
        case .failure(let error):
            throw error
        }
    }
    
    func reescheduleAppointment(appointmentID: String, newDate: String) async throws -> ScheduleAppointmentResponse? {
        let result = await service.reescheduleAppointment(appointmentID: appointmentID, newDate: newDate)
        switch result {
        case .success(let schedule):
            return schedule
        case .failure(let error):
            throw error
        }
    }
    
    func cancelAppointment(appointmentID: String, reasonToCancel: String) async throws -> Bool {
        let result = await service.cancelAppointment(appointmentID: appointmentID, reasonToCancel: reasonToCancel)
        switch result {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    func appointmentsByPatient(patientID: String) async throws -> [Appointment]? {
        let result = await service.appointmentsByPatient(patientID: patientID)
        switch result {
        case .success(let appointments):
            return appointments
        case .failure(let error):
            throw error
        }
    }
}
