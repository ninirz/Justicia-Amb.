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


struct UserDetails {
    
    var email: String
    var profileImageUrl: String
}



var uid1 = ""
var logged = false

struct LoginView: View {
    
    
//    @State private var logged = false
    
    @State private var sec = false
    
    var body: some View {
        VStack{
            
            if(logged){
                UserDetailsView(userId: uid1)
                
            } else {
                if !sec {
                    LogInView()
                    
                } else {
                    SignInView()
                    
                }
            }
            
        }
        
    }
    
    
    
    
}



struct UserDetailsView: View {
    
    var userId: String
    
    @State private var userDetails: UserDetails?
    @State private var loading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView{
            VStack {
                if loading {
                    ProgressView()
                } else if let userDetails = userDetails {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Email: \(userDetails.email)")
                        AsyncImage(url: URL(string: userDetails.profileImageUrl)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            .onAppear {
                fetchUserDetails()
            }
            .navigationTitle("User Details")
        }.navigationBarBackButtonHidden(true)
        
    }

    private func fetchUserDetails() {
        loading = true
        let ref = FirebaseManager.shared.firestore.collection("Users").document(userId)
        ref.getDocument { document, error in
            if let error = error {
                errorMessage = "Error fetching user details: \(error.localizedDescription)"
                loading = false
                return
            }
            
            guard let document = document, document.exists, let data = document.data() else {
                errorMessage = "No user details found"
                loading = false
                return
            }
            
            let email = data["email"] as? String ?? "No email"
            let profileImageUrl = data["profileImageUrl"] as? String ?? ""
            
            userDetails = UserDetails(email: email, profileImageUrl: profileImageUrl)
            loading = false
        }
    }
}





struct LogInView: View {
    
    @State var isLoginMode = true
    @State var shouldShowImagePicker = false
    @State var us = User()
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                
                VStack{
                    Text("Ingresa")
                        .foregroundColor(.blue)
                        .font(.system(size: 54, weight: .semibold))
                        
                    
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
                        
                        SecureField("Contraseña", text: $us.password)
                    }
                    .padding(10)
                    .cornerRadius(15)
                    .background(.white)
                    
                    
                    Button {
                        loginUser()
                        
                    } label: {
                        HStack{
                            Spacer()
                            Text("Ingresar")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }
                                            
                    }
                    .background(Color.blue)
                    .cornerRadius(15)
                    .padding()
                    .scaledToFit()
                    
                    if(uid1 != ""){
                        NavigationLink(destination: UserDetailsView(userId: uid1)) {
                            Text("Amonos")
                        }
                    }
                        
                    
                    
                    Text(self.loginStatusMessage)
                        .foregroundColor(.blue)

                }
            }
            .navigationBarHidden(true)
            
        }
        
    }
    
    @State var image: UIImage?
    
    private func loginUser(){
        FirebaseManager.shared.auth.signIn(withEmail: self.us.email, password: self.us.password){
            result, err in
            if let err = err{
                print("Failed to login user ", err)
                self.loginStatusMessage = "Failed to loginUser the message \(err)"
                
                return
            }
            
            uid1 = result?.user.uid ?? ""
            
            
//            print("Succesfully logged in as user:\(result?.user.uid ?? "") ")
            
            
            self.loginStatusMessage = ("Succesfully logged in as user:\(result?.user.uid ?? "") ")
        }
    }
    
    
    @State var loginStatusMessage = ""
    
    
}



struct SignInView: View {
    
    @State private var isActive = false
    @State var isLoginMode = false
    @State var shouldShowImagePicker = false
    @State var us = User()
    @State var uid1 = ""
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                
                VStack{
                    Text("Registrate")
                        .foregroundColor(.blue)
                        .font(.system(size: 54, weight: .semibold))
                        
                    
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
                        
                        SecureField("Contraseña", text: $us.password)
                    }
                    .padding(10)
                    .cornerRadius(15)
                    .background(.white)
                    
                    
                    Button {
                        handleAction()
                        
                    } label: {
                        HStack{
                            Spacer()
                            Text("Registrarme")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }
                                            
                    }
                    .background(Color.blue)
                    .cornerRadius(15)
                    .padding()
                    .scaledToFit()
                    
                    if(uid1 != ""){
                        NavigationLink(destination: UserDetailsView(userId: uid1)) {
                            Text("Amonos")
                        }
                    }
                        
                    
                    
                    Text(self.loginStatusMessage)
                        .foregroundColor(.blue)

                }
            }
            .navigationBarHidden(true)
            
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
            
            uid1 = result?.user.uid ?? ""
            
//            print("Succesfully logged in as user:\(result?.user.uid ?? "") ")
            
            
//            self.loginStatusMessage = ("Succesfully logged in as user:\(result?.user.uid ?? "") ")
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
            
//            self.loginStatusMessage = ("Succesfully created user:\(result?.user.uid ?? "") ")
            
            self.persistImageToStorage()
        }
        
        
    }
    
    private func persistImageToStorage(){
//        let filename = UUID().uuidString
        
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
                
                
//                self.loginStatusMessage = "Succesfully stored image with url \(url?.absoluteString ?? "")"
                
                print(url?.absoluteString)
                
                guard let url = url else {return}
                
                storeUserInformation(imageProfileUrl: url)
                
                
                
            }
            
        }
    }
    
    private func storeUserInformation(imageProfileUrl: URL){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
        let userData = ["email": self.us.email, "uid": uid, "profileImageUrl": imageProfileUrl.absoluteString]
        FirebaseManager.shared.firestore.collection("Users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    self.loginStatusMessage = "\(err)"
                    return
                }
                
            }
        
        
    }
    
}

