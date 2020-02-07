//
//  test.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 07..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import CodableFirebase
import Combine


class test: ObservableObject {
    
    @Published var string = "hello"

    
    var subscriptions =  Set<AnyCancellable>()
    var ref: DatabaseReference!
    
    init(){

        //var productsPublisher = PassthroughSubject<DataSnapshot, Error>()

        let subscriber = ProductPublisher.allProduct()
        let ratings = RatingPublisher.averageRating(for: 2)
        let asd = RatingPublisher.allRating(for: 1, type: .uploaderId)
        
        subscriber.subject
            .print("ALLPRODUCTSPUBLISHER")
            .sink(receiveCompletion: { (value) in
                print(value)
            }) { (products) in
                print("")
        }
        .store(in: &subscriptions)
        
        ratings.subject
        .print("RATINGS")
            .sink(receiveCompletion: { (value) in
                print(value)
            }) { (avg) in
                print(avg)
            }
            .store(in: &subscriptions)
        
        asd.subject
        .print("TEXT")
            .sink(receiveCompletion: { (value) in
                print(value)
            }) { (ratings) in
                print(ratings)
        }
    .store(in: &subscriptions)
        
    }
}
