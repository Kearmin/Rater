//
//  UserCommentMode.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 03. 13..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine

class UserCommentModel {
    
    func getComments(id: Int) -> AnyPublisher<[Rating],Error> {
        
        return RatingPublisher.allRating(for: id, type: .uploaderId).subject.eraseToAnyPublisher()
    }
    
    func getId(for name: String) -> AnyPublisher<Int, AppError> {
        return UserPublisher().userId(for: name).subject.eraseToAnyPublisher()
    }
    
}
