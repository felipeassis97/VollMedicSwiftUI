//
//  PickerHealthPlanFormView.swift
//  Vollmed
//
//  Created by Felipe Assis on 13/01/24.
//

import SwiftUI

struct PickerHealthPlanFormView: View {
    //MARK: Atributes
    let options: [String]
    
    //MARK: States
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

#Preview {
    PickerHealthPlanFormView(options: ["Amil", "Unimed", "Bradesco Saúde", "SulAmérica"], controller: .constant("Controller"))
}
