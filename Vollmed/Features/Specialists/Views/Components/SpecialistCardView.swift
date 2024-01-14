//
//  SpecialistCardView.swift
//  Vollmed
//
//  Created by Felipe Assis on 09/01/24.
//

import SwiftUI
import UIKit

struct SpecialistCardView: View {
    
    //MARK: Atributes
    var appointment: Appointment?
    var specialist: Specialist
    let imageService: DownloadImageServiciable = DownloadImageService()
    
    //MARK: States
    @State private var profileImage: UIImage?

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16.0) {
                
                if let profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(specialist.name)
                        .font(.title3)
                        .bold()
                    Text(specialist.specialty)
                    
                    if let appointment {
                        Text(appointment.date.dateToFormatString())
                    }
                }
            }
            
            if let appointment {
                HStack {
                    
                    NavigationLink {
                        ScheduleAppointmentPage(specialistID: specialist.id, isRescheduleView: true, appointmentID: appointment.id)
                    } label: {
                        ButtonView(text: "Reagendar")
                    }
                    
                    NavigationLink {
                        CancelAppointmentPage(appointmentID: appointment.id)
                    } label: {
                        ButtonView(text: "Cancelar", buttonType: .cancel)

                    }
                }
            } else {
                NavigationLink {
                    ScheduleAppointmentPage(specialistID: specialist.id)
                } label: {
                    ButtonView(text: "Agendar consulta")
                }
            }
    
 
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.lightBlue).opacity(0.15))
        .cornerRadius(16.0)
        .task {
            do {
                if let image = try await imageService.dowloadImage(from: specialist.imageUrl) {
                    profileImage = image
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

#Preview {
    SpecialistCardView(specialist:
        Specialist(id: "c84k5kf",
                   name: "Dr. Carlos Alberto",
                   crm: "123456",
                   imageUrl: "https://images.unsplash.com/photo-1637059824899-a441006a6875?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=752&q=80",
                   specialty: "Neurologia",
                   email: "carlos.alberto@example.com",
                   phoneNumber: "(11) 99999-9999"
                  ))
}
