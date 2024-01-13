//
//  RedectedAnimationModifier.swift
//  Vollmed
//
//  Created by Felipe Assis on 13/01/24.
//
import SwiftUI

struct RedectedAnimationModifier: ViewModifier {
    
    @State private var isRedected: Bool = true
    
    func body(content: Content) -> some View {
        content
            .opacity(isRedected ? 0 : 1)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true)) {
                    self.isRedected.toggle()
                }
            }
    }
}

extension View {
    func redactedAnimation () -> some View {
        modifier(RedectedAnimationModifier())
    }
}
