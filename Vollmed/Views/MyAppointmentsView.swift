//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Felipe Assis on 10/01/24.
//

import SwiftUI

struct MyAppointmentsView: View {
    let service = WebService()
    
    let authManager = AuthManager.instance
    
    @State private var appointments: [Appointment] = []
    
    func getAppointmentsByUser() async {
        do {
            guard let patientID = authManager.patientID else { return }
            if let schedules = try await service.getAllApointmentsFromPatient(patientID: patientID) {
                appointments = schedules
                print(schedules)
            }
        }
        catch {
            print("Erro ao buscar as consultas!")
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(appointments) { appointment in
                    SpecialistCardView(appointment: appointment, specialist: appointment.specialist)
                }
            }
        }
        .navigationTitle("Minhas consultas")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .onAppear {
            Task {
                await getAppointmentsByUser()
            }
        }
        
    }
}

#Preview {
    MyAppointmentsView()
}
