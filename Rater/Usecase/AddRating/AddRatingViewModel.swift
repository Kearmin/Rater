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
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
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
        
        guard let user = ObjectContainer.sharedInstace.user else {
            self.isError = true
            self.errorMessage = "Please log in to post Ratings"
            return
        }
        
        let rating = Rating(text: self.description, uploaderId: user.id, rating: self.currentRating, id: ObjectContainer.sharedInstace.refIds.ratingId, productId: self.productId, title: self.title)
        self.model.createRating(rating: rating)
        ObjectContainer.sharedInstace.refIds.ratingId += 1
    }
}
