//
//  Rating.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 07..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation

struct Rating: Codable {
    let text: String
    let uploaderId: Int
    let rating: Int
    let id: Int
    let productId: Int
    let title: String
}
