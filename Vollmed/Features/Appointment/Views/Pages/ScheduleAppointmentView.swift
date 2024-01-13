//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Felipe Assis on 09/01/24.
//

import SwiftUI
import UIKit

struct ScheduleAppointmentView: View {
    
    let specialistID: String
    let isRescheduleView: Bool
    let appointmentID: String?
    
    let service = WebService()
    let authManager = AuthManager.instance

    
    @State private var selectDate = Date()
    @State private var showAlert = false
    @State private var isAppointmentSchedule = false
    @Environment(\.dismiss) var navigationPop

    init(specialistID: String, isRescheduleView: Bool = false, appointmentID: String? = nil) {
        self.specialistID = specialistID
        self.isRescheduleView = isRescheduleView
        self.appointmentID = appointmentID
    }
    
    func scheduleAppointment() async {
        do {
            guard let patientID = authManager.patientID else { return }
            if let appointment = try await service.scheduleAppointment(specialistID: specialistID, patientID: patientID, date: selectDate.toString()) {
                print(appointment)
                isAppointmentSchedule = true
            } else {
                isAppointmentSchedule = false
                
            }
        } catch {
            isAppointmentSchedule = true
            print("Erro ao agendar consulta \(error)")
        }
        showAlert = true
    }
    
    func reScheduleAppointment() async {
        guard let appointmentID else { return }
        
        do {
            if let _ =  try await service.reescheduleAppointment(appointmentID: appointmentID, newDate: selectDate.toString()) {
                isAppointmentSchedule = true
            }
            else {
                isAppointmentSchedule = false
            }
        } catch {
            print("Ocorreu um erro! \(error)")
            isAppointmentSchedule = false
        }
        
        showAlert = true
        
    }
    
    var body: some View {
        VStack {
            Text("Selecione a data e o horário da consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            DatePicker("Escolha a data da consulta", selection: $selectDate, in: Date.now...)
                .datePickerStyle(.graphical)
            
            Button(action: {
                Task {
                    isRescheduleView ? await reScheduleAppointment() : await scheduleAppointment()
                }}, label: {
                    ButtonView(text:
                                isRescheduleView ? "Reagenda consulta" : "Agendar consulta")
                })
        }
        .padding()
        .navigationTitle(isRescheduleView ? "Reagenda consulta" : "Agendar consulta")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 15
        }
        .alert(isAppointmentSchedule ? "Sucesso" : "Ops, algo deu errado!",
               isPresented: $showAlert,
               presenting: isAppointmentSchedule) { _ in
            Button(action: {
                if isAppointmentSchedule {
                    navigationPop()

                }
                
            }, label: {
                Text("OK")
            })
        } message: { isScheduled in
            if isScheduled {
                Text("Consulta foi \(isRescheduleView ? "reagendada" : "agendada") com sucesso")
            } else {
                Text("Houve um erro ao \(isRescheduleView ? "reagendar" : "agendar") sua consulta. Por favor, tente novamente ou entre em contato via telefone.")
            }
        }
    }
}

#Preview {
    ScheduleAppointmentView(specialistID: "123")
}
