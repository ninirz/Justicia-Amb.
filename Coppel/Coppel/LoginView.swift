//
//  ContentView.swift
//  tesit
//
//  Created by DAVID BT on 4/23/24.
//

import SwiftUI

struct User {
    var email = ""
    var password = ""
    var age = ""
    var wakeUP = Date()
}

struct LoginView: View {
    
    @State var isLoginMode = false
    @State var us = User()
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack(spacing: 16){
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                        
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding()
                    
                    Button {
                        handleAction()
                    } label : {
                        Image(systemName: "person.fill")
                            .font(.system(size: 64))
                            .padding()
                    }
                    
                    Group{
                        TextField("Email", text: $us.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        TextField("Password", text: $us.password)
                        DatePicker("Ingresa la fecha", selection: $us.wakeUP, displayedComponents: [.date])
                            .labelsHidden()
                            .blur(radius: !isLoginMode ? 0 : 100)
                        
                    }
                    .padding(12)
                    .background(.white)
                    
                    Button {
                        handleAction()
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
    
    private func handleAction(){
        if(isLoginMode){
            print("Should login to firebase with an existing account")
            
        } else {
            print("Register a new account inside of Firebase Auth and then store image in Storage somehow....")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
