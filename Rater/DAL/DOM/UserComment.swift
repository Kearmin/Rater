//
//  UserComments.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 08. 16..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation

struct UserComment: Codable {
    let id: Int
    let productImageUrl: URL?
    let productName: String
    let text: String
    let rating: Int
}
