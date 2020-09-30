//
//  PageService.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 08. 15..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine

struct PageService {
    
    let pageSize = 10
    
    func getAllProduct(searchText: String? = nil, afterId: Int? = nil, userId: Int? = nil) -> AnyPublisher<[Product], Error> {
        
        guard let url = API.getProductPage(pageSize: pageSize, searchText: searchText, afterId: afterId, userId: nil) else {
            return Fail<[Product], Error>(error: AppError.undefined)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Product].self, decoder: JSONDecoder())
            .print("GetAllProduct", to: nil)
            .share()
            .eraseToAnyPublisher()
    }
    
    func getUserRatings(userId: Int, pageSize: Int, afterId: Int?) -> AnyPublisher<[UserComment], Error> {
        
        guard let url = API.getUserComments(id: userId, pageSize: pageSize, afterId: afterId) else {
            return Fail<[UserComment], Error>(error: AppError.undefined).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .map {
                print(String(data: $0, encoding: .utf8) as Any)
                return $0
            }
            .decode(type: [UserComment].self, decoder: JSONDecoder())
            .print("UserComments", to: nil)
            .share()
            .eraseToAnyPublisher()
    }
}
