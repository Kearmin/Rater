//
//  RatingProvider.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 07..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine
import CodableFirebase

enum IdType {
    case ratingId
    case uploaderId
    case productId
}

class RatingPublisher {
    
    static func allRating(for id: Int, type: IdType) -> FireBaseSubject<[Rating],Error>{
        
        let subject = PassthroughSubject<[Rating], Error>()
        
        let handle = ObjectContainer.sharedInstace.dbReference.child("Ratings").observe(.value) { (snapshot) in
            print(snapshot.value as Any)
            
            var ratings: [Rating]? = nil
            
            if let ratingsDict = try? FirebaseDecoder().decode([String:Rating?].self, from: snapshot.value as Any) {
                ratings = ratingsDict.map { $0.1 }.compactMap{ $0 }
            } else if let ratingsArray = try? FirebaseDecoder().decode([Rating?].self, from: snapshot.value as Any) {
                ratings = ratingsArray.compactMap { $0 }
            }
            
            if var ratings = ratings {
                
                ObjectContainer.sharedInstace.refIds.ratingId = ratings.map { $0.id }.max()!
                
                switch type {
                case .ratingId:
                    ratings = ratings.filter { $0.id == id}
                case .productId:
                    ratings = ratings.filter { $0.productId == id}
                case .uploaderId:
                    ratings = ratings.filter { $0.uploaderId == id}
                }
                
                ratings = ratings.sorted(by: { (r1, r2) -> Bool in
                    r1.id < r2.id
                })
                
                subject.send(ratings)
            } else {
                subject.send(completion: .failure(AppError.undefined))
            }
        }
        
        let firebaseSubject = FireBaseSubject(subject: subject, handler: handle)
        
        return firebaseSubject
    }
    
    static func averageRating(for id: Int) -> FireBaseSubject<Double, Error>{
        
        let subject = PassthroughSubject<Double, Error>()
        
        let handle = ObjectContainer.sharedInstace.dbReference.child("Ratings").observe(.value) { (snapshot) in
            print(snapshot.value as Any)
            
            var ratings: [Rating]? = nil
            
            if let ratingsDict = try? FirebaseDecoder().decode([String:Rating?].self, from: snapshot.value as Any) {
                ratings = ratingsDict.map { $0.1 }.compactMap{ $0 }
            } else if let ratingsArray = try? FirebaseDecoder().decode([Rating?].self, from: snapshot.value as Any) {
                ratings = ratingsArray.compactMap { $0 }
            }
            
            if var ratings = ratings {
                
                ratings = ratings.filter{ rating -> Bool in
                    rating.productId == id
                }
                
                let averageRating = Double(ratings.reduce(0) { $0 + $1.rating})
                let count = ratings.count
                
                if count < 1 {
                    subject.send(0.0)
                } else if count == 1 {
                    subject.send(Double(ratings.first!.rating))
                } else {
                    subject.send(averageRating/Double(count))
                }
            } else {
                subject.send(completion: .failure(AppError.undefined))
            }
            
            
        }
        
        let firebaseSubject = FireBaseSubject(subject: subject, handler: handle)
        
        return firebaseSubject
        
    }
}
