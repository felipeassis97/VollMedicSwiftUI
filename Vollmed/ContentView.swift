//
//  ContentView.swift
//  Vollmed
//
//  Created by Felipe Assis on 09/01/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label(title: {
                    Text("Home")
                },
                      icon: { Image(systemName: "house") }
                )}
            
            NavigationStack {
                MyAppointmentsView()
            }
            .tabItem {
                Label(title: {
                    Text("Minhas consultas")
                }, icon: {
                    Image(systemName: "calendar")
                }
                )}
        }
    }
}

#Preview {
    ContentView()
}
