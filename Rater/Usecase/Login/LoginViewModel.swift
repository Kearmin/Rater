//
//  LoginViewModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 07. 05..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var loggedInUser: String? = nil

    var subscriptions = Set<AnyCancellable>()
    
    let model: LoginModel
    
    init(model: LoginModel) {
        self.model = model
        
        self.loggedInUser = ObjectContainer.sharedInstace.user?.accountName
    }
    
    func logOut() {
        ObjectContainer.sharedInstace.user = nil
        self.loggedInUser = nil
        self.username = ""
        self.password = ""
    }
    
    func login() {
        
        if self.username.count < 3 || self.password.count < 3 {
            self.isError = true
            self.errorMessage = "Username and password should be at least 3 char long"
            return
        }
        
        self.model.login(username: self.username, password: self.password)
            .sink(receiveCompletion: { completion in
                print(completion)
            }) { isValid in
                if isValid {
                    guard let user = ObjectContainer.sharedInstace.user else {
                        return
                    }
                    self.loggedInUser = user.accountName
                } else {
                    self.isError = true
                    self.errorMessage = "Invalid username or password"
                }
            }
            .store(in: &subscriptions)
    }
    
    func canSignUp() {
        
        if self.username.count < 3 || self.password.count < 3 {
            self.isError = true
            self.errorMessage = "Username and password should be at least 3 char long"
            return
        }
        
        self.model.canSignUp(username: self.username)
            .sink(receiveCompletion: { completion in
                print(completion)
            }) { canSignup in
                if canSignup {
                    self.signUp()
                } else {
                    self.showAlreadySignedUp()
                }
            }
            .store(in: &subscriptions)
    }
    
    func showAlreadySignedUp() {
        self.isError = true
        self.errorMessage = "Already signed up"
    }
    
    func signUp() {
        self.model.signUp(username: self.username, password: self.password)
        self.errorMessage = "Successful signed up, please log in"
        self.isError = true
    }
    
}
