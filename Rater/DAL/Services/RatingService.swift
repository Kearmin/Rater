//
//  RatingService.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 08. 15..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine

struct RatingService {
    
    func createRating(rating: Rating) -> AnyPublisher<RatingDetail, Error> {
        
        guard let jsonData = try? JSONEncoder().encode(rating) else {
            return Fail<RatingDetail, Error>(error: AppError.undefined).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: API.createRating())
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let token = ObjectContainer.sharedInstace.token {
            request.setValue( "Bearer \(token.value)", forHTTPHeaderField: "Authorization")
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: RatingDetail.self, decoder: JSONDecoder())
            .print("CreateRating")
            .eraseToAnyPublisher()
    }
}
