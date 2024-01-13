//
//  SignupView.swift
//  Vollmed
//
//  Created by Felipe Assis on 11/01/24.
//

import SwiftUI

struct SignupPage: View {
    
    //MARK: Atributes
    let authViewModel = AuthViewModel(auth: AuthService())
    let healthPlans: [String] = ["Amil", "Unimed", "Bradesco Saúde", "SulAmérica", "Hapvida", "Notredame Intermédica", "Outro"]
   
    //MARK: States
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var cpf: String = ""
    @State private var phone: String = ""
    @State private var password: String = ""
    @State private var healthPlan: String = "Amil"
    @State var showSnackBarError: Bool = false
    @State var createAccountSuccess: Bool = false
    @State var navigatoToSigninView: Bool = false
  
    var body: some View {
        ZStack {
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
                    
                    CustomFormFieldView(title: "Nome", placeholder: "Insira seu nome completo", keyboardType: .default, controller: $name)
                    CustomFormFieldView(title: "Email", placeholder: "Insira seu email", keyboardType: .emailAddress,  controller: $email)
                    CustomFormFieldView(title: "CPF", placeholder: "Insira seu CPF", keyboardType: .numberPad, controller: $cpf)
                    CustomFormFieldView(title: "Telefone", placeholder: "Insira seu telefone", keyboardType: .numberPad, controller: $phone)
                    CustomPasswordFormFieldView(controller: $password)
                    PickerHealthPlanFormView(options: healthPlans, controller: $healthPlan)
                    
                    Button(action: {
                        Task {
                            let result = await authViewModel.signUp(cpf: cpf, name: name, email: email, password: password, plan: healthPlan, phone: phone)
                            if !result {
                                showSnackBarError = true
                                createAccountSuccess = false
                            } else {
                                navigatoToSigninView = true
                                createAccountSuccess = true
                            }
                        }
                        
                    }, label: {
                        ButtonView(text: "Cadastrar")
                    })
                    
                    NavigationLink {
                        SigninPage()
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
            .navigationDestination(isPresented: $navigatoToSigninView) {
                SigninPage()
            }
                        
            if showSnackBarError {
                SnackBarView(message: createAccountSuccess ? "Conta criada com sucesso!" :
                                "Ops! Ocorreu um erro ao criar sua conta. Verifique suas credenciais e tente novamente.",
                             isSuccess: createAccountSuccess, isShowing: $showSnackBarError)
            }
        }
    }
}

#Preview {
    SignupPage()
}









