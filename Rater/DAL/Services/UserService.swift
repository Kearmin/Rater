//
//  UserService.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 08. 15..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine

struct UserService {
    
    func login(username: String, password: String) -> AnyPublisher<Token, Error> {
        
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let url = API.login()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Basic VGVzenQxMjMuOlRlc3p0MTIzLg==
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Token.self, decoder: JSONDecoder())
            .print("Login")
            .eraseToAnyPublisher()
    }
    
    func signUp(username: String, password: String) -> AnyPublisher<User, Error> {
        
        let dict = [
            "accountName" : "\(username)",
            "password" : "\(password)"
        ] as [String: String]
        
        struct Asd: Codable {
            let accountName: String
            let password: String
        }
        
        let asd = Asd(accountName: username, password: password)
        
        let jsonData = try! JSONEncoder().encode(asd)
        
        var request = URLRequest(url: API.signUp())
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: User.self, decoder: JSONDecoder())
            .print("SignUp")
            .eraseToAnyPublisher()
    }
    
    func logout() -> AnyPublisher<Void, Error> {
        
        var request = URLRequest(url: API.logout())
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        if let token = ObjectContainer.sharedInstace.token {
            request.setValue("Bearer \(token.value)", forHTTPHeaderField: "Authorization")
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { _ in return () }
            .mapError { urlError -> Error in
                print(urlError)
                return AppError.undefined
            }
            .print("Logout")
            .eraseToAnyPublisher()
    }
    
    func me() -> AnyPublisher<User, Error> {
        
        var request = URLRequest(url: API.me())
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let token = ObjectContainer.sharedInstace.token {
            request.setValue("Bearer \(token.value)", forHTTPHeaderField: "Authorization")
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .map {
                print(String(data: $0, encoding: .utf8) as Any)
                return $0
            }
            .print("Me")
            .decode(type: User.self, decoder: JSONDecoder())
            .share()
            .eraseToAnyPublisher()
    }
}
