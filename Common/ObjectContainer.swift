//
//  ObjectContainer.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 07..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ObjectContainer {
    
    static var sharedInstace = ObjectContainer()
    
    var dbReference: DatabaseReference!
    
    private init(){
        self.dbReference = Database.database().reference()
    }
}
