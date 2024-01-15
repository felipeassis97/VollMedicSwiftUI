//
//  ChangeAppointmentCardView.swift
//  Vollmed
//
//  Created by Felipe Assis on 15/01/24.
//

import SwiftUI

struct ChangeAppointmentCardView: View {
    
    //MARK: Atributes
    var appointment: Appointment
    var specialist: Specialist
    let imageService: DownloadImageServiciable = DownloadImageService()
    
    //MARK: States
    @State private var profileImage: UIImage?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(height: 260)
            .foregroundColor(.white)
            .shadow(color: .gray.opacity(0.1), radius: 16)
            .overlay(
                alignment: .leading,
                content: {
                    VStack(alignment: .leading) {
                        Text(appointment.date.dateToFormatString())
                            .font(.customFont2(type: .inter, style: .bold, size: 14))
                            .padding(.horizontal, 16)
                        Divider()
                            .padding(.horizontal, 16)

                        HStack(alignment: .center) {
                            if let profileImage {
                                Image(uiImage: profileImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .padding(.leading, 16)
                                    .padding(.trailing, 8)
                                    .padding(.vertical, 8)
                            }
                            VStack(alignment: .leading) {
                                Text(appointment.specialist.name)
                                    .font(.customFont2(type: .inter, style: .bold, size: 16))
                                    .foregroundStyle(.black.opacity(0.9))

                                Text(appointment.specialist.specialty)
                                    .font(.customFont2(type: .inter, style: .semiBold, size: 14))
                                    .foregroundStyle(.black.opacity(0.6))
                            }
                        }
                        Divider()
                        HStack(alignment: .center) {
                            NavigationLink {
                                CancelAppointmentPage(appointmentID: appointment.id)
                            } label: {
                                ButtonView(text: "Cancelar", buttonType: .cancel)
                            }
                            NavigationLink {
                                ScheduleAppointmentPage(specialistID: specialist.id, isRescheduleView: true, appointmentID: appointment.id)
                            } label: {
                                ButtonView(text: "Reagendar")
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                
            )
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .onAppear {
                Task {
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
    
}
//
//#Preview {
//    ChangeAppointmentCardView(specialist:
//                                Specialist(id: "c84k5kf",
//                                           name: "Dr. Carlos Alberto",
//                                           crm: "123456",
//                                           imageUrl: "https://images.unsplash.com/photo-1637059824899-a441006a6875?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=752&q=80",
//                                           specialty: "Neurologia",
//                                           email: "carlos.alberto@example.com",
//                                           phoneNumber: "(11) 99999-9999"
//                                          ))
//}
