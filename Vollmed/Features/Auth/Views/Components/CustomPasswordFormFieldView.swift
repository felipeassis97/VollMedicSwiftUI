//
//  CustomPasswordFormFieldView.swift
//  Vollmed
//
//  Created by Felipe Assis on 13/01/24.
//

import SwiftUI

struct CustomPasswordFormFieldView: View {
    //MARK: States
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

#Preview {
    CustomPasswordFormFieldView(controller: .constant("controller"))
}
