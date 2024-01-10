//
//  WebService.swift
//  Vollmed
//
//  Created by Felipe Assis on 09/01/24.
//

import UIKit

struct WebService {
    
    private let baseURL = "http://localhost:3000"
    
   
    
    
    func reescheduleAppointment(appointmentID: String, newDate: String) async throws -> ScheduleAppointmentResponse? {
        let endpoint = baseURL + "/consulta/" + appointmentID
        guard let url = URL(string: endpoint) else { return nil }
        
        do {
            
            let requestData: [String: Any] = ["data" : newDate]
            let jsonBody = try JSONSerialization.data(withJSONObject: requestData)
            
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonBody
            
            let (data, _) =  try await URLSession.shared.data(for: request)
            let appointments = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)
            return appointments
        } catch {
            return nil
        }
    }
    
    
    func getAllApointmentsFromPatient(patientID: String) async throws -> [Appointment]? {
        let endpoint = baseURL + "/paciente/" + patientID + "/consultas"
        guard let url = URL(string: endpoint) else { return nil }
        
        do {
            let (data, _) =  try await URLSession.shared.data(from: url)
            let schedules = try JSONDecoder().decode([Appointment].self, from: data)
            return schedules
        } catch {
            return nil
        }
    }
    
    func scheduleAppointment(specialistID: String,
                             patientID: String,
                             date: String) async throws -> ScheduleAppointmentResponse? {
        
        let endpoint = baseURL + "/consulta"
        guard let url = URL(string: endpoint) else { return nil }
        
        do {
            let appointment = ScheduleAppointmentRequest(specialistID: specialistID, patientID: patientID, date: date)
            let body = try JSONEncoder().encode(appointment)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
            
            let (data, _) =  try await URLSession.shared.data(for: request)
            let appointments = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)
            return appointments
        } catch {
            return nil
        }
    }
    
    func dowloadImage(from imageURL: String) async throws -> UIImage? {
        
        let imageCache = NSCache<NSString, UIImage>()
        guard let url = URL(string: imageURL) else { return UIImage(named: "Logo") ?? nil }
        
        //Check if exists in cache
        if let cachedImage = imageCache.object(forKey: imageURL as NSString) {
            return cachedImage
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image =  UIImage(data: data) else {
                return UIImage(named: "Logo") ?? nil
            }
            //Save in cache
            imageCache.setObject(image, forKey: imageURL as NSString)
            return image
        }
        catch {
            return UIImage(named: "Logo") ?? nil
        }
    }
    
    func getAllSpecialists() async throws -> [Specialist]? {
        let endpoint = baseURL + "/especialista"
        guard let url = URL(string: endpoint) else { return nil }
        do {
            let (data, _) =  try await URLSession.shared.data(from: url)
            let specialists = try JSONDecoder().decode([Specialist].self, from: data)
            return specialists
        } catch {
            return nil
        }
    }
}
