//
//  UserPublisher.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 07. 05..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine
import CodableFirebase

class UserPublisher {
    
    func canSignUp(username: String) -> FireBaseSubject<Bool, AppError> {
        
        let subject = PassthroughSubject<Bool, AppError>()
        
        let handle = ObjectContainer.sharedInstace.dbReference.child("Users").observe(.value) { snapshot in
            
            var users: [User]? = nil
            
            if let usersDict = try? FirebaseDecoder().decode([String:User?].self, from: snapshot.value as Any) {
                users = usersDict.map { $0.1 }.compactMap{ $0 }
            } else if let usersArray = try? FirebaseDecoder().decode([User?].self, from: snapshot.value as Any) {
                users = usersArray.compactMap { $0 }
            }
         
            if let users = users {
                
                ObjectContainer.sharedInstace.refIds.userId = users.map { $0.id }.max()!
                
                var alreadySignedUp = false
                
                for user  in users {
                    if user.accountName.lowercased() == username.lowercased() {
                        alreadySignedUp = true
                    }
                }
                                
                subject.send(alreadySignedUp)
                
            } else {
                subject.send(completion: .failure(AppError.undefined))
            }
        }
        
        let firebaseSubject = FireBaseSubject(subject: subject, handler: handle)
        
        return firebaseSubject
    }
    
    func userId(for name: String) -> FireBaseSubject<Int, AppError> {
        
        let subject = PassthroughSubject<Int, AppError>()
        
        let handle = ObjectContainer.sharedInstace.dbReference.child("Users").observe(.value) { snapshot in
            
            var users: [User]? = nil
            
            if let usersDict = try? FirebaseDecoder().decode([String:User?].self, from: snapshot.value as Any) {
                users = usersDict.map { $0.1 }.compactMap{ $0 }
            } else if let usersArray = try? FirebaseDecoder().decode([User?].self, from: snapshot.value as Any) {
                users = usersArray.compactMap { $0 }
            }
            
            if let users = users {
                
                ObjectContainer.sharedInstace.refIds.userId = users.map { $0.id }.max()!
                
                var found = false
                
                for user  in users {
                    if user.accountName.lowercased() == name.lowercased() {
                        subject.send(user.id)
                        found = true
                        break
                    }
                }
                
                if found == false {
                    subject.send(completion: .failure(AppError.undefined))
                }
                
            } else {
                subject.send(completion: .failure(AppError.undefined))
            }
        }
        
        let firebaseSubject = FireBaseSubject(subject: subject, handler: handle)
        return firebaseSubject
    }
    
     func loginUser(username: String, password: String) -> FireBaseSubject<Bool, AppError> {
        
        let subject = PassthroughSubject<Bool, AppError>()
        
        let handle = ObjectContainer.sharedInstace.dbReference.child("Users").observe(.value) { (snapshot) in
            print(snapshot.value as Any)
            
            var users: [User]? = nil
            
            if let usersDict = try? FirebaseDecoder().decode([String:User?].self, from: snapshot.value as Any) {
                users = usersDict.map { $0.1 }.compactMap{ $0 }
            } else if let usersArray = try? FirebaseDecoder().decode([User?].self, from: snapshot.value as Any) {
                users = usersArray.compactMap { $0 }
            }
            
            if let users = users {
                
                ObjectContainer.sharedInstace.refIds.userId = users.map { $0.id }.max()!
                
                var found = false
                
                for user  in users {
                    if user.password == password, user.accountName == username {
                        found = true
                        ObjectContainer.sharedInstace.user = user
                    }
                }
                
                subject.send(found)
            } else {
                subject.send(completion: .failure(AppError.undefined))
            }
        }
        
        let firebaseSubject = FireBaseSubject(subject: subject, handler: handle)
        
        return firebaseSubject
    }
}
