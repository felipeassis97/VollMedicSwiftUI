//
//  SignupView.swift
//  Vollmed
//
//  Created by Felipe Assis on 11/01/24.
//

import SwiftUI
import SimpleToast


struct SignupView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var cpf: String = ""
    @State private var phone: String = ""
    @State private var password: String = ""
    @State private var healthPlan: String
    @State var showAlert: Bool = false
    @State var isSuccess: Bool = false
    
    let healthPlans: [String] = ["Amil", "Unimed", "Bradesco Saúde", "SulAmérica", "Hapvida", "Notredame Intermédica", "Outro"]
    let service = WebService()
    
    init() {
        self.healthPlan = healthPlans[0]
    }
    
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
                
                FormItemView(title: "Nome", placeholder: "Insira seu nome completo", keyboardType: .default, controller: $name)
                FormItemView(title: "Email", placeholder: "Insira seu email", keyboardType: .emailAddress,  controller: $email)
                FormItemView(title: "CPF", placeholder: "Insira seu CPF", keyboardType: .numberPad, controller: $cpf)
                FormItemView(title: "Telefone", placeholder: "Insira seu telefone", keyboardType: .numberPad, controller: $phone)
                PasswordFormItemView(controller: $password)
                HealthPlanItemView(options: healthPlans, controller: $healthPlan)
                
                Button(action: {
                    Task {
                        do {
                            let patient = Patient(id: nil, cpf: cpf, name: name, email: email, password: password, plan: healthPlan, phone: phone)
                            
                            let response =  try await service.registerPatient(patient: patient)
                            
                            if response {
                                isSuccess = true
                            } else {
                                print("Erro ao cadastrar paciente else")
                                isSuccess = false
                            }
                        }
                        catch {
                            print("Erro ao cadastrar paciente: \(error)")
                            isSuccess = false
                        }
                        showAlert = true
                    }
                    
                }, label: {
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
        .simpleToast(isPresented: $showAlert, options: SimpleToastOptions(
            hideAfter: 5
        )) {
            Label(isSuccess ? "Cadastro efetuado com sucesso!" : "Ocorreu um erro ao efetuar seu cadastro. por favor, tente novamente!",
                  systemImage: isSuccess ? "person.badge.shield.checkmark.fill" : "exclamationmark.triangle"  )
                .padding()
                .background(isSuccess ? Color.green.opacity(0.8) : Color.red.opacity(0.8))
                .foregroundColor(Color.white)
                .cornerRadius(16)
                .padding()
        }
    }
}

#Preview {
    SignupView()
}

struct HealthPlanItemView: View {
    let options: [String]
    @Binding var controller: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Escolha seu plano de saúde")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            
            Picker("Planos de saúde", selection: $controller) {
               ForEach(options, id: \.self) { plan in
                    Text(plan)
                }
            }
        }
    }
}


struct PasswordFormItemView: View {
    @Binding var controller: String
    
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
    @Binding var controller: String
    
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


