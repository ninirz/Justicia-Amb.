//
//  ContentView.swift
//  tesit2
//
//  Created by DAVID BT on 4/23/24.
//

import SwiftUI
import Firebase
import FirebaseStorage


struct User {
    var email = ""
    var password = ""
    var age = ""
    var wakeUP = Date()
}


class FirebaseManager : NSObject {
    let auth: Auth
    let storage: Storage
    
    static let shared = FirebaseManager()
    
    override init(){
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        
        super.init()
    }
    
}

struct LoginView: View {
    
    
    @State var isLoginMode = false
    @State var shouldShowImagePicker = false
    @State var us = User()
    
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
                        shouldShowImagePicker
                            .toggle()
                        
                    } label : {
                        
                        VStack{
                            if let image = self.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                    .scaledToFit()
                                    .cornerRadius(64)
                                
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 64))
                                    .padding()
                            }
                        }
                        
                        
                    }
                    
                    Group{
                        TextField("Email", text: $us.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $us.password)
                            
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
                    
                    Text(self.loginStatusMessage)
                        .foregroundColor(.red)
                }
                .padding()
                
                
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                .ignoresSafeArea())
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
        }
    }
    
    @State var image: UIImage?
    
    private func handleAction(){
        isLoginMode ? loginUser() : createNewAccount()
    }
    
    private func loginUser(){
        FirebaseManager.shared.auth.signIn(withEmail: self.us.email, password: self.us.password){
            result, err in
            if let err = err{
                print("Failed to login user ", err)
                self.loginStatusMessage = "Failed to loginUser the message \(err)"
                return
            }
            
            print("Succesfully logged in as user:\(result?.user.uid ?? "") ")
            
            self.loginStatusMessage = ("Succesfully logged in as user:\(result?.user.uid ?? "") ")
        }
    }
    
    
    @State var loginStatusMessage = ""
    
    private func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: self.us.email, password: self.us.password){
            result, error in
            if let err = error{
                print("Failed to create user ", err)
                self.loginStatusMessage = "Failed to create the message \(err)"
                return
            }
            
            print("Succesfully created user:\(result?.user.uid ?? "") ")
            
            self.loginStatusMessage = ("Succesfully created user:\(result?.user.uid ?? "") ")
            
            self.persistImageToStorage()
        }
        
        
    }
    
    private func persistImageToStorage(){
        let filename = UUID().uuidString
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid
        else {return}
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else {return}
        
        ref.putData(imageData, metadata: nil){ metadata, err in
            if let err = err {
                self.loginStatusMessage = "Failed to push image to storage \(err)"
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
                    return
                }
                
                
                self.loginStatusMessage = "Succesfully stored image with url \(url?.absoluteString ?? "")"
                
                
                
            }
            
            
        }
    }
    
    
}
