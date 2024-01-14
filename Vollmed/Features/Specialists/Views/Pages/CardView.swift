//
//  CardView.swift
//  Vollmed
//
//  Created by Felipe Assis on 14/01/24.
//

import SwiftUI

struct CardView: View {
    //MARK: Atributes
    var appointment: Appointment?
    var specialist: Specialist
    let imageService: DownloadImageServiciable = DownloadImageService()
    
    //MARK: States
    @State private var profileImage: UIImage?
    
    var body: some View {
        NavigationLink {
            ScheduleAppointmentPage(specialistID: specialist.id)
        } label: {
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 100)
                .foregroundColor(.white)
                .shadow(color: .gray.opacity(0.1), radius: 16)
                .overlay(
                    alignment: .leading,
                    content: {
                        HStack(spacing: 2) {
                            if let profileImage {
                                Image(uiImage: profileImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .padding(.leading, 32)
                                    .padding(.trailing, 8)
                                
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text(specialist.name)
                                    .bold()
                                    .font(.title3)
                                Text(specialist.specialty)
                                    .font(.subheadline)
                                    .foregroundStyle(.black.opacity(0.7))
                            }
                            Spacer()
                            Image(.arrowRight)
                                .padding(.trailing, 16)
                        }
                    })
        }
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

#Preview {
    CardView(specialist:
                Specialist(id: "c84k5kf",
                           name: "Dr. Carlos Alberto",
                           crm: "123456",
                           imageUrl: "https://images.unsplash.com/photo-1637059824899-a441006a6875?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=752&q=80",
                           specialty: "Neurologia",
                           email: "carlos.alberto@example.com",
                           phoneNumber: "(11) 99999-9999"
                          ))
}
