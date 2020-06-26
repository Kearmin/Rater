//
//  FirebaseWriteOperations.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 04. 20..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Firebase

class FirebaseWriteOperations {
    
    private let ref: DatabaseReference?
    
    init(databaseReference: DatabaseReference?) {
        self.ref = databaseReference
    }
    
    func createProduct(product: Product) {
        
        guard let ref = ref else { return }
        
        ref.child("Products").child("\(ObjectContainer.sharedInstace.refIds.productId + 1)").setValue(
            [
                "name": product.name,
                "description": product.description,
                "id": ObjectContainer.sharedInstace.refIds.ratingId + 1,
                "producer": product.producer,
                "uploaderId": product.uploaderId,
                "category": product.category.intValue()
            ]
        )
    }
    
    func createRating(rating: Rating) {
        
        guard let ref = ref else { return }
        
        ref.child("Ratings").child("\(ObjectContainer.sharedInstace.refIds.ratingId + 1)").setValue(
            [
                "productId": rating.productId,
                "rating": rating.rating,
                "text": rating.text,
                "id": ObjectContainer.sharedInstace.refIds.ratingId + 1,
                "title": rating.title,
                "uploaderId": rating.uploaderId
            ]
        )
    }
    
    func createUser(user: User) {
        
        guard let ref = ref else { return }
        
        ref.child("Users").child("\(user.id)").setValue(
            [
                "accountName": user.accountName,
                "password": user.password,
                "id": user.id
            ]
        )
    }
    
}
