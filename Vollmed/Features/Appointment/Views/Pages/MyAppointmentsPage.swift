//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Felipe Assis on 10/01/24.
//

import SwiftUI

struct MyAppointmentsPage: View {
    
    //MARK: Atributes
    let appointmentsViewModel = AppointmentsViewModel(service: AppointmentService())
    let authManager = AuthManager.instance
    
    //MARK: States
    @State private var appointments: [Appointment] = []
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(appointments) { appointment in                    
                    ChangeAppointmentCardView(appointment: appointment, specialist: appointment.specialist)
                }
            }
        }
        .navigationTitle("Minhas consultas")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .onAppear {
            Task {
                do {
                    guard let patientID = authManager.patientID else { return }
                    if let schedules = try await appointmentsViewModel.appointmentsByPatient(patientID: patientID) {
                        appointments = schedules
                    }
                }
                catch {
                    print("Erro ao buscar as consultas!")
                }
            }
        }
    }
}

#Preview {
    MyAppointmentsPage()
}
