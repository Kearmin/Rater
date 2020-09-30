//
//  AddRatingModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 07. 05..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine

class AddRatingModel {
    
    let ratingService = RatingService()

    init() {
    }
        
    func createRating(rating: Rating) -> AnyPublisher<RatingDetail, Error> {

        return ratingService.createRating(rating: rating)
    }
    
}
