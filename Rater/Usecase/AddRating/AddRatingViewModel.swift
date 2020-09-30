//
//  AddRatingViewModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 07. 05..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine

class AddRatingViewModel: ObservableObject {
    
    @Published var description: String = ""
    @Published var title: String = ""
    @Published var currentRating: Int = 1
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
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
        
        model.createRating(rating: Rating(text: self.description, uploaderId: user.id, rating: self.currentRating, id: -1, productId: self.productId, title: self.title))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                print(result)
            }) { rating in
                self.description = ""
                self.currentRating = 1
                self.errorMessage = "Success"
                self.isError = true
                self.title = ""
            }
        .store(in: &subscriptions)
    }
}
