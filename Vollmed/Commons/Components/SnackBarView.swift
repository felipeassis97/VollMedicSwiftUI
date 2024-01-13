//
//  SnackBarView.swift
//  Vollmed
//
//  Created by Felipe Assis on 13/01/24.
//

import SwiftUI

struct SnackBarView: View {
    
    //MARK: Atributes
    let message: String
    let isSuccess: Bool?
    var success: Bool {
        return isSuccess ?? false
    }
    
    //MARK: States
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            Spacer()
            if isShowing {
                HStack(spacing: 20) {
                    if success {
                        Image(systemName: "person.fill.checkmark.rtl")
                            .font(.title2)
                    } else {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.title2)
                    }
                    Text(message)
                }
                .padding()
                .background(success ? .accent : .red)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .transition(.move(edge: .bottom))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            isShowing = false
                        }
                        
                    }
                }
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

#Preview {
    SnackBarView(message: "Ops! Ocorreu um erro, mas já esta sendo solucionado", isSuccess: nil,  isShowing: .constant(true))
}
