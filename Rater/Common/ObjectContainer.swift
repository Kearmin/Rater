//
//  ObjectContainer.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 07..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Firebase

struct DatabaseReferenceIds {
    var productId: Int
    var ratingId: Int
    var userId: Int
}

class ObjectContainer {
    
    static var sharedInstace = ObjectContainer()
    
    var dbReference: DatabaseReference!
    var refIds = DatabaseReferenceIds(productId: 0, ratingId: 0, userId: 0)
    var user = User(id: 0, accountName: "temp", password: "aksjd")
    
    private init(){
        self.dbReference = Database.database().reference()
    }
}
