//
//  HomeView.swift
//  Vollmed
//
//  Created by Felipe Assis on 09/01/24.
//

import SwiftUI

struct SpecialistsPage: View {
    
    //MARK: Atributes
    let specialistsViewModel = SpecialistsViewModel(service: SpecialistsNetworkinService())
    let authViewModel = AuthViewModel(auth: AuthService())
    
    //MARK: States
    @State private var specialistsD: [Specialist] = []
    @State private var isShowingSnackBar: Bool = false
    @State private var isLoading: Bool = true
    @State private var errorMessage: String = ""
    
    var body: some View {
        
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .padding(.vertical, 32)
                    Text("Boas-vindas!")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color(.lightBlue))
                    Text("Veja abaixo os especialistas da Vollmed disponíveis e marque já a sua consulta!")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.accentColor)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 16)
                    
                    if isLoading {
                        SkeletonView()
                    } else {
                        ForEach(specialistsD) { specialist in
                            CardView(specialist: specialist)
                                .padding(.bottom, 8)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
            .onAppear {
                Task {
                    do {
                        guard let response = try await specialistsViewModel.getSpecialists() else { return }
                        specialistsD = response
                    } catch {
                        isShowingSnackBar = true
                        let errorType = error as? RequestError
                        errorMessage = errorType?.customMessage ?? "Ops! Ocorreu um erro"
                    }

                    isLoading = false
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        Task {
                            await authViewModel.signOut()
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.forward")
                                .foregroundStyle(.accent)
                            Text("Logout")
                                .foregroundStyle(.accent)
                        }
                    })
                }
            }
        }
        
        if isShowingSnackBar {
            SnackBarView(message: errorMessage,isSuccess: nil, isShowing: $isShowingSnackBar)
        }
    }
}

#Preview {
    SpecialistsPage()
}
