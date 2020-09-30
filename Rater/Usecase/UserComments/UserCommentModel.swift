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
    
    let pageSize = 999
    var lastId: Int? = nil
    let pageService = PageService()
    
    func load(id: Int) -> AnyPublisher<[UserComment], Error> {
        return pageService.getUserRatings(userId: id, pageSize: pageSize, afterId: lastId)
    }
}
