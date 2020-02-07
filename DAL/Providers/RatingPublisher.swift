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
    case id
    case uploaderId
    case productId
}

class RatingPublisher {
    
    static func allRating(for id: Int, type: IdType) -> FireBaseSubject<[Rating],Error>{
        
        let subject = PassthroughSubject<[Rating], Error>()
        
        let handle = ObjectContainer.sharedInstace.dbReference.child("Ratings").observe(.value) { (snapshot) in
            
            do {
                //print(snapshot.value as Any)
                var ratings = try FirebaseDecoder().decode([Rating].self, from: snapshot.value as Any)
                
                switch type {
                case .id:
                    ratings = ratings.filter({ $0.id == id})
                case .productId:
                    ratings = ratings.filter({ $0.productId == id})
                case .uploaderId:
                    ratings = ratings.filter({ $0.uploaderId == id})
                }
        
                subject.send(ratings)
                
            } catch let error {
                subject.send(completion: .failure(error))
            }
        }
        
        let firebaseSubject = FireBaseSubject(subject: subject, handler: handle)
        
        return firebaseSubject
    }
    
    static func averageRating(for id: Int) -> FireBaseSubject<Double, Error>{
        
        let subject = PassthroughSubject<Double, Error>()
        
        let handle = ObjectContainer.sharedInstace.dbReference.child("Ratings").observe(.value) { (snapshot) in
            
            do {
                //print(snapshot.value as Any)
                let ratings = try FirebaseDecoder().decode([Rating].self, from: snapshot.value as Any).filter({ $0.productId == id})
                
                let averageRating = Double(ratings.reduce(0) { $0 + $1.rating})
                let count = Double(ratings.count)
                print("xd")
                subject.send(averageRating/count)
                
            } catch let error {
                subject.send(completion: .failure(error))
            }
        }
        
        let firebaseSubject = FireBaseSubject(subject: subject, handler: handle)
        
        return firebaseSubject
        
    }
}
