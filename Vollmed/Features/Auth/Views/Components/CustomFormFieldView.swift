//
//  CustomFormFieldView.swift
//  Vollmed
//
//  Created by Felipe Assis on 13/01/24.
//

import SwiftUI

struct CustomFormFieldView: View {
    //MARK: Atributes
    let title: String
    let placeholder: String
    let keyboardType: UIKeyboardType?
    
    //MARK: States
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
#Preview {
    CustomFormFieldView(title: "Telefone", placeholder: "Insira seu telefone", keyboardType: .numberPad, controller: .constant("controller"))
}
