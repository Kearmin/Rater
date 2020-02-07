//
//  ProductPublisher.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 07..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine
import FirebaseDatabase
import Firebase
import CodableFirebase


class FireBaseSubject<T: Codable, E:Error> {
    
    let handler: UInt
    let subject: PassthroughSubject<T, E>
    
    init(subject: PassthroughSubject<T, E>, handler: UInt){
        self.subject = subject
        self.handler = handler
    }
    
    deinit {
        ObjectContainer.sharedInstace.dbReference.removeObserver(withHandle: self.handler)
    }
}

class ProductPublisher {
    
    init(){}
    
    static func allProduct() -> FireBaseSubject<[Product], Error> {
        
        let subject = PassthroughSubject<[Product], Error>()
        
        let handle = ObjectContainer.sharedInstace.dbReference.child("Products").observe(.value) { (snapshot) in
            
            do {
                //print(snapshot.value as Any)
                var products = try FirebaseDecoder().decode([Product].self, from: snapshot.value as Any)
                subject.send(products)
            } catch let error {
                subject.send(completion: .failure(error))
            }
        }
        
        let firebaseSubject = FireBaseSubject(subject: subject, handler: handle)
        
        return firebaseSubject
    }
    
}
