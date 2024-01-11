//
//  CancelApointmentView.swift
//  Vollmed
//
//  Created by Felipe Assis on 11/01/24.
//

import SwiftUI

struct CancelApointmentView: View {
    
    let appointmentID: String
    let service = WebService()
    @State private var reasonToCancel = ""
    @State private var showAlert = false
    @State private var successCancel = false
    @Environment(\.dismiss) var navigationPop
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Conte-nos o motivo do cancelamento da sua consulta")
                .font(.title3)
                .foregroundStyle(.accent)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            TextEditor(text: $reasonToCancel)
                .padding(.horizontal, 16.0)
                .font(.title3)
                .foregroundColor(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.lightBlue).opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 16.0))
                .frame(maxHeight: 300)
            
            Button(action: {
                Task {
                    do {
                        try await service.cancelAppointment(appointmentID: appointmentID, reasonToCancel: reasonToCancel)
                        successCancel = true
                    }
                    catch {
                        print("Error: \(error)")
                        successCancel = false
                    }
                    showAlert = true
                }
            }, label: {
                ButtonView(text: "Cancela consulta", buttonType: .cancel)
            })
        }
        .padding()
        .navigationTitle("Cancela consulta")
        .navigationBarTitleDisplayMode(.inline)
        .alert(successCancel ? "Successo" : "Error", isPresented: $showAlert) {
            Button(action: {
                
                if successCancel {
                    navigationPop()
                }
                
            }, label: {
                Text("OK")
            })
        } message: {
            Text(successCancel ? "Consulta cancelada com sucesso" : "Ocorreu um erro ao cancelar sua consulta. Por favor, tente novamente ou entre em contato via telefone.")
        }
    }
}

#Preview {
    CancelApointmentView(appointmentID: "123")
}
