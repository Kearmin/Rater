//
//  ProductPublisher.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 07..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine
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
    
    static func allProduct(id: Int?, type: IdType) -> FireBaseSubject<[Product], Error> {
        
        let subject = PassthroughSubject<[Product], Error>()
        
        let handle = ObjectContainer.sharedInstace.dbReference.child("Products").observe(.value) { (snapshot) in
            print(snapshot.value as Any)
            
            var products: [Product]? = nil
            
            if let productsDict = try? FirebaseDecoder().decode([String:Product?].self, from: snapshot.value as Any) {
                products = productsDict.map { $0.1 }.compactMap{ $0 }
            } else if let productsArray = try? FirebaseDecoder().decode([Product?].self, from: snapshot.value as Any) {
                products = productsArray.compactMap { $0 }
            }
            
            if var products = products {
            
                ObjectContainer.sharedInstace.refIds.productId = products.map { $0.id }.max()!
                
                if let id = id {
                    switch type {
                    case .productId:
                        products = products.filter{ $0.id == id }
                    case .uploaderId:
                        products = products.filter{ $0.uploaderId == id }
                    default:
                        break
                    }
                }
                
                products = products.sorted(by: { (p1, p2) -> Bool in
                    p1.id < p2.id
                })
                
                subject.send(products)
            } else {
                subject.send(completion: .failure(AppError.undefined))
            }
        }
//
//            do {
//                //print(snapshot.value as Any)
//                let productsDict = try FirebaseDecoder().decode([String:Product].self, from: snapshot.value as Any)
//
//                //let data = try JSONSerialization.data(withJSONObject: snapshot.value)
//
//                //let re = try JSONDecoder().decode([String: Product].self, from: data).compactMap { $0 }
//
//                var products = productsDict.map { $0.1 }
//
//                ObjectContainer.sharedInstace.refIds.productId = products.map { $0.id }.max()!
//
//                if let id = id {
//                    switch type {
//                    case .productId:
//                        products = products.filter{ $0.id == id }
//                    case .uploaderId:
//                        products = products.filter{ $0.uploaderId == id }
//                    default:
//                        break
//                    }
//                }
//
//                products = products.sorted(by: { (p1, p2) -> Bool in
//                    p1.id < p2.id
//                })
//
//                subject.send(products)
//            } catch let error {
//                print(error)
//                subject.send(completion: .failure(error))
//            }
//        }
        
        let firebaseSubject = FireBaseSubject(subject: subject, handler: handle)
        
        return firebaseSubject
    }
}
