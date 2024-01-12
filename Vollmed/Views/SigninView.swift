//
//  SigninView.swift
//  Vollmed
//
//  Created by Felipe Assis on 11/01/24.
//

import SwiftUI
import SimpleToast

struct SigninView: View {
    
    let service = WebService()
    var authManager = AuthManager.instance
    
    @State private var emailTextField: String = ""
    @State private var passwordTextField: String = ""
    
    @State var showAlert: Bool = false
    @State var isSuccess: Bool = false
    @State var navigatoToHomeView: Bool = false
    
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
            
            Button(action: {
                Task {
                    
                    do {
                        if let response = try await service.loginPatient(email: emailTextField, password: passwordTextField) {
                            
                            authManager.saveToken(token: response.token)
                            authManager.savePatientID(id: response.id)
                            isSuccess = true
                        }
                        else {
                            isSuccess = false
                        }
                    } catch {
                        isSuccess = false
                    }
                    showAlert = true
                }
                
            }, label: {
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
        .navigationDestination(isPresented: $navigatoToHomeView) {
            //SigninView()
        }
        .simpleToast(isPresented: $showAlert, options: SimpleToastOptions(
            hideAfter: 3
        ), onDismiss: {
            if isSuccess { navigatoToHomeView = true }
        }) {
            Label(isSuccess ? "Login efetuado com sucesso!" : "Ocorreu um erro ao efetuar seu login. por favor, tente novamente!",
                  systemImage: isSuccess ? "person.badge.shield.checkmark.fill" : "exclamationmark.triangle")
            .padding()
            .background(isSuccess ? Color.green.opacity(0.8) : Color.red.opacity(0.8))
            .foregroundColor(Color.white)
            .cornerRadius(16)
            .padding()
        }
    }
}

#Preview {
    SigninView()
}
