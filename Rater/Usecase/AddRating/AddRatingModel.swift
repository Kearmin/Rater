//
//  AddRatingModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 07. 05..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation

class AddRatingModel {
    
    let provider: FirebaseWriteOperations

    init() {
        self.provider = FirebaseWriteOperations(databaseReference: ObjectContainer.sharedInstace.dbReference)
    }
    
    func createRating(rating: Rating) {
        self.provider.createRating(rating: rating)
    }
    
}
