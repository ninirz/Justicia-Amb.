//
//  CourseView.swift
//  Coppel
//
//  Created by Wendy Sanchez Cortes on 24/04/24.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            
            VStack {
                Text("Coppel")
                    .font(.custom("Poppins-Bold", size: 50))
                    .foregroundColor(.blueCoppel)
                    .frame(width: 260, alignment: .center)
                
                NavigationLink(destination: LoginView()) {
                    HStack {
                        Image(systemName: "arrow.forward")
                        Text("Inicio de sesión")
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 260, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                
                NavigationLink(destination: HomeView()) {
                    HStack {
                        Image(systemName: "arrow.forward")
                        Text("Registro")
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 260, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(
                RiveViewModel(fileName: "shapes").view()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .blur(radius: 15)
                    .blendMode(.hardLight)
            )
            
            .background(Color.yellowCoppel)
        }
       
        
    }
}

#Preview {
    ContentView()
}
