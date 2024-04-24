//
//  ContentView.swift
//  Coppel
//
//  Created by Wendy Sanchez Cortes on 23/04/24.
//

import SwiftUI
import RiveRuntime

struct HomeView: View {
    
    @State var selectedTab: Tab = .timer
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    switch selectedTab {
                    case .chat:
                        LoginView(isLoginMode: false, us: User())
                    case .search:
                        CoursesView()
                    case .timer:
                        ContentView()
                    case .bell:
                        CoursesView()
                    case .user:
                        QuizView()
                    }
                    Spacer()
                }
                .ignoresSafeArea()
                TabBar(selectedTab: $selectedTab)
            }
            
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeView()
}
