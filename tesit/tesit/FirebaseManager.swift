//
//  FirebaseManager.swift
//  tesit
//
//  Created by DAVID BT on 4/24/24.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore


class FirebaseManager : NSObject {
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init(){
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
    
}
