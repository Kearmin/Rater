//
//  ProductService.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 08. 15..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine

struct ProductService {
    
    let pageSize = 999
    
    func getProduct(id: Int) -> AnyPublisher<ProductDetail, Error> {
        
        return URLSession.shared
            .dataTaskPublisher(for: API.getProduct(id: id))
            .retry(1)
            .map(\.data)
            .decode(type: ProductDetail.self, decoder: JSONDecoder())
            .print("GetProduct")
            .share()
            .eraseToAnyPublisher()
    }
        
    func createProduct(product: Product) -> AnyPublisher<Product, Error> {
        
        guard let jsonData = try? JSONEncoder().encode(product) else {
            return Fail<Product,Error>(error: AppError.undefined).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: API.createProduct(product: product))
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let token = ObjectContainer.sharedInstace.token {
            request.setValue("Bearer \(token.value)", forHTTPHeaderField: "Authorization")
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Product.self, decoder: JSONDecoder())
            .print("CreateProduct", to: nil)
            .eraseToAnyPublisher()
    }
}
