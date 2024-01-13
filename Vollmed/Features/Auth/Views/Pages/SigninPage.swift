//
//  SigninView.swift
//  Vollmed
//
//  Created by Felipe Assis on 11/01/24.
//

import SwiftUI

struct SigninPage: View {
    
    //MARK: Atributes
    let authViewModel = AuthViewModel(auth: AuthService())

    //MARK: States
    @State private var email: String = ""
    @State private var password: String = ""
    @State var showSnackBarError: Bool = false
    @State var navigatoToHomeView: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 36, alignment: .center)
                
                Text("Olá")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)
                
                Text("Preencha para acessar sua conta")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                CustomFormFieldView(title: "Email", placeholder: "Insira seu email", keyboardType: .emailAddress,  controller: $email)
    
                CustomPasswordFormFieldView(controller: $password)
                
                Button(action: {
                    Task {
                        let result = await authViewModel.signIn(email: email, password: password)
                        if !result {
                            showSnackBarError = true
                        }
                    }
                    
                }, label: {
                    ButtonView(text: "Entrar")
                })
                
                NavigationLink {
                    SignupPage()
                } label: {
                    Text("Ainda não possui uma conta? Cadastre-se")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
            }
            .padding()
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $navigatoToHomeView) {
                //SigninView()
            }
            
            if showSnackBarError {
                SnackBarView(message: "Ops! Ocorreu um erro, verifique suas credenciais e tente novamente.",
                             isSuccess: nil,
                             isShowing: $showSnackBarError)
            }
        }
    }
}

#Preview {
    SigninPage()
}
