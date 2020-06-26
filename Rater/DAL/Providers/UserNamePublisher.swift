//
//  UserNamePublisher.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 06. 06..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine
import CodableFirebase

class UserNamePublisher {
    
    static func userName(for id: Int) -> FireBaseSubject<String, Error> {
        
        
        let subject = PassthroughSubject<String, Error>()
        
        let handle = ObjectContainer.sharedInstace.dbReference.child("Users").observe(.value) { (snapshot) in
            
            print(snapshot.value as Any)
            do {
                
                let users = try FirebaseDecoder().decode([User].self, from: snapshot.value as Any)
                
                let user = users.filter { $0.id == id}
                
                if user.count > 0 {
                    subject.send(user[0].accountName)
                } else {
                    subject.send("deleted")
                }
                
            } catch let error {
                subject.send(completion: .failure(error))
            }
        }
        
        let firebaseSubject = FireBaseSubject(subject: subject, handler: handle)
        
        return firebaseSubject
    }
}
