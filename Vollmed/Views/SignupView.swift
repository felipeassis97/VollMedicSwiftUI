//
//  SignupView.swift
//  Vollmed
//
//  Created by Felipe Assis on 11/01/24.
//

import SwiftUI

struct SignupView: View {
    
    @State private var name = ""
    @State private var email = ""
    @State private var cpf = ""
    @State private var phone = ""
    @State private var password = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack (alignment: .leading, spacing: 16.0) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center)
                    .padding(.vertical)
                
                Text("Olá, boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)
                
                
                Text("Insira seus dados para criar uma conta.")
                    .font(.title3 )
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                FormItemView(title: "Nome", placeholder: "Insira seu nome completo", controller: name)
                FormItemView(title: "Email", placeholder: "Insira seu email", keyboardType: .emailAddress, controller: email)
                FormItemView(title: "CPF", placeholder: "Insira seu CPF", keyboardType: .numberPad, controller: cpf)
                FormItemView(title: "Telefone", placeholder: "Insira seu telefone", keyboardType: .numberPad, controller: phone)
                PasswordFormItemView(controller: password)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    ButtonView(text: "Cadastrar")
                })
                
                NavigationLink {
                    SigninView()
                } label: {
                    Text("Já possui uma conta? Faça o login!")
                        .bold()
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity)
                }
                
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        .safeAreaPadding()
    }
}

#Preview {
    SignupView()
}



struct PasswordFormItemView: View {
    @State var controller: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Senha")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            
            SecureField("Insira sua senha", text: $controller)
                .padding(14)
                .background(.gray.opacity(0.15))
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .clipShape(RoundedRectangle(cornerRadius: 16.0))
        }
    }
}

struct FormItemView: View {
    let title: String
    let placeholder: String
    let keyboardType: UIKeyboardType?
    @State var controller: String
    
    init(title: String, placeholder: String, keyboardType: UIKeyboardType = .default, controller: String) {
        self.title = title
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.controller = controller
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            
            TextField(placeholder, text: $controller)
                .padding(14)
                .background(.gray.opacity(0.15))
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .clipShape(RoundedRectangle(cornerRadius: 16.0))
        }
    }
}
