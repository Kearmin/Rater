//
//  API.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 08. 15..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation


struct API {
    
    //static var baseURL = "http://127.0.0.1:8080"
    static var baseURL = "http://Jenos-MacBook-Pro.local:8080"
    //static var baseURL = "http://192.168.0.110:8080"
        
    static func getProduct(id: Int) -> URL {
        return URL(string: baseURL + "/product/\(id)")!
    }
    
    static func getProductPage(pageSize: Int, searchText: String?, afterId: Int?, userId: Int?) -> URL? {
        
        var urlComps = URLComponents(string: baseURL + "/pages/products")!
        
        urlComps.queryItems = [.init(name: "pageSize", value: "\(pageSize)")]
        
        if let searchText = searchText {
            urlComps.queryItems?.append(.init(name: "searchText", value: "\(searchText)"))
        }
        
        if let afterId = afterId {
            urlComps.queryItems?.append(.init(name: "afterId", value: "\(afterId)"))
        }
        
        if let userId = userId {
            urlComps.queryItems?.append(.init(name: "userId", value: "\(userId)"))
        }

        return try? urlComps.asURL()
    }
    
    static func getProductDetail(id: Int) -> URL {
        return URL(string: baseURL + "/product/\(id)")!
    }
    
    static func getUserComments(id: Int, pageSize: Int, afterId: Int?) -> URL? {
        var urlComps = URLComponents(string: baseURL + "/pages/ratingsForUser")!
        
        urlComps.queryItems = [
            .init(name: "id", value: "\(id)"),
            .init(name: "pageSize", value: "\(pageSize)")
        ]
        
        if let afterId = afterId {
            urlComps.queryItems?.append(.init(name: "afterId", value: "\(afterId)"))
        }

        return try? urlComps.asURL()
    }
    
    static func createProduct(product: Product) -> URL {
        let url = URL(string: baseURL + "/product")!
        
        return url
    }
    
    static func createRating() -> URL {
        return URL(string: baseURL + "/rating")!
    }
    
    static func login() -> URL {
        return URL(string: baseURL + "/user/login")!
    }
    
    static func signUp() -> URL {
        return URL(string: baseURL + "/user/signup")!
    }
 
    static func logout() -> URL {
        return URL(string: baseURL + "/user/logout")!
    }
    
    static func me() -> URL {
        return URL(string: baseURL + "/user/me")!
    }
}
