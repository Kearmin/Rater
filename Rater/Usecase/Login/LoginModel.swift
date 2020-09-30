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
    
    let userService = UserService()
    
    init() {
    }
    
    func logout() -> AnyPublisher<Void, Error> {
        
        userService.logout()
    }
    
    func login(username: String, password: String) -> AnyPublisher<Token, Error> {

        userService.login(username: username, password: password)
    }

    func signUp(username: String, password: String) -> AnyPublisher<User, Error> {
        
        userService.signUp(username: username, password: password)
    }
    
    func me() -> AnyPublisher<User, Error> {
        userService.me()
    }
    
}
