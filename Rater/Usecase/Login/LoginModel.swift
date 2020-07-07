//
//  LoginModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 07. 05..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine

class LoginModel {
    
    let provider = UserPublisher()
    let writeProvider: FirebaseWriteOperations
    
    init() {
        self.writeProvider = FirebaseWriteOperations.init(databaseReference: ObjectContainer.sharedInstace.dbReference)
    }
    
    func login(username: String, password: String) -> AnyPublisher<Bool, AppError>{
        return self.provider.loginUser(username: username, password: password).subject.eraseToAnyPublisher()
    }
    
    func canSignUp(username: String) -> AnyPublisher<Bool, AppError> {
        return self.provider.canSignUp(username: username).subject.eraseToAnyPublisher()
    }
    
    func signUp(username: String, password: String) {
        
        let user = User(id: ObjectContainer.sharedInstace.refIds.userId + 1, accountName: username, password: password)
        self.writeProvider.createUser(user: user)
        ObjectContainer.sharedInstace.refIds.userId += 1
    }
    
}
