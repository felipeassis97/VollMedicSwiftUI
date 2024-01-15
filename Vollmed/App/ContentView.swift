//
//  ContentView.swift
//  Vollmed
//
//  Created by Felipe Assis on 09/01/24.
//

import SwiftUI

struct ContentView: View {
    //MARK: Monitora se existe a variavel no storage (funciona como uma stream)
    //@AppStorage(AppKeys.userToken) var token: String = ""
    
    //MARK: Irá reagir as mudancas das variaveis @Published
    @ObservedObject var authManager = AuthManager.instance
    
    var body: some View {
        if authManager.token == nil {
            NavigationStack {
                SigninPage()
            }
        } else {
            TabView {
                NavigationStack {
                    SpecialistsPage()
                }
                .tabItem {
                    Label(title: {
                        Text("Home")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    },
                          icon: { Image(systemName: "house") }
                    )}
                
                NavigationStack {
                    MyAppointmentsPage()
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
}

#Preview {
    ContentView()
}
