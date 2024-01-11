//
//  SigninView.swift
//  Vollmed
//
//  Created by Felipe Assis on 11/01/24.
//

import SwiftUI

struct SigninView: View {
    
    @State private var emailTextField: String = ""
    @State private var passwordTextField: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center)
            
            Text("Olá")
                .font(.title2)
                .bold()
                .foregroundStyle(.accent)
            
            Text("Preencha para acessar sua conta")
                .font(.title3)
                .foregroundStyle(.gray)
                .padding(.bottom)
            
            Text("Email")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            
            TextField("Insira seu email", text: $emailTextField)
                .padding(14)
                .background(.gray.opacity(0.15))
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .clipShape(RoundedRectangle(cornerRadius: 16.0))
            
            
            Text("Senha")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            
            SecureField("Insira sua senha", text: $passwordTextField)
                .padding(14)
                .background(.gray.opacity(0.15))
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .clipShape(RoundedRectangle(cornerRadius: 16.0))
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                ButtonView(text: "Entrar")
            })
            
            NavigationLink {
                SignupView()
            } label: {
                Text("Ainda não possui uma conta? Cadastre-se")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
   
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SigninView()
}
