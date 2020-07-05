//
//  AddRatingViewModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 07. 05..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation

class AddRatingViewModel: ObservableObject {
    
    @Published var description: String = ""
    @Published var title: String = ""
    @Published var currentRating: Int = 1
    
    let productId: Int
    let model: AddRatingModel
    
    init(model: AddRatingModel, productId: Int) {
        self.model = model
        self.productId = productId
    }
    
    func changeRatingTo(_ rating: Int) {
        self.currentRating = rating
    }
    
    func createRating() {
        
        let rating = Rating(text: self.description, uploaderId: ObjectContainer.sharedInstace.user.id, rating: self.currentRating, id: ObjectContainer.sharedInstace.refIds.ratingId, productId: self.productId, title: self.title)
        self.model.createRating(rating: rating)
        ObjectContainer.sharedInstace.refIds.ratingId += 1
    }
}
