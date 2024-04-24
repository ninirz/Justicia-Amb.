//
//  ContentView.swift
//  tesit
//
//  Created by DAVID BT on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                VStack(spacing: 16){
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        
                        Text("Create Account")
                            .tag(false)
                        
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding()
                    
                    Button{
                        
                        
                    } label : {
                        Image(systemName: "person.fill")
                            .font(.system(size: 64))
                            .padding()
                    }
                    
                    Group{
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        TextField("Password", text: $password)
                    }
                    .padding(12)
                    .background(.white)
                    
                    
                    Button {
                        
                    } label: {
                        HStack{
                            Spacer()
                            Text(isLoginMode ? "Log In" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }
                        
                    }
                    .background(Color.blue)
                    .cornerRadius(15)
                }
                .padding()
                
                
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
        }
    }
}

