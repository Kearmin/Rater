//
//  Product.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 07..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation

struct Product: Codable {
    let name: String
    let id: Int
    let uploaderId: Int
    let producer: String
    let description: String
    let imageUrl: String?
    let category: Category
    let price: Double?
}

enum Category: Int, Codable {
    case clothes = 0
    case food
    case technology
    case furniture
    case cosmetics
    case toys
    case videoGames
    case cars
    case undefined
}
