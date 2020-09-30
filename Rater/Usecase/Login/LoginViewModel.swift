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
                
        model.logout()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                default:
                    break
                }
            }) { _ in
                ObjectContainer.sharedInstace.user = nil
                self.loggedInUser = nil
                self.username = ""
                self.password = ""
        }
        .store(in: &subscriptions)
    }
    
    func login() {
        
        if self.username.count < 3 || self.password.count < 6 {
            self.isError = true
            self.errorMessage = "Username should at least 3 and password should be at least 6 char long"
            return
        }
        
        model.login(username: username, password: password)
            .map { token -> Token in
                ObjectContainer.sharedInstace.token = token
                return token
            }
        .flatMap { _ in
            self.model.me()
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { (result) in
            switch result {
            case .failure(let error):
                self.isError = true
                self.errorMessage = error.localizedDescription
            default:
                break
            }
        }) { user in
            self.loggedInUser = user.accountName
            ObjectContainer.sharedInstace.user = user
        }
        .store(in: &subscriptions)
    }
    
//    func showAlreadySignedUp() {
//        self.isError = true
//        self.errorMessage = "Already signed up"
//    }
    
    func signUp() {
        self.model.signUp(username: self.username, password: self.password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                default:
                    break
                }
            }) { _ in
                self.errorMessage = "Successful signed up, please log in"
                self.isError = true
        }
        .store(in: &subscriptions)
    }
}
