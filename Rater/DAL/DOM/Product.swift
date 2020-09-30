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
    let imageUrl: URL?
    let barcode: String
}

enum Category: Int, Codable {
    case clothes = 0
    case food = 1
    case technology = 2
    case furniture = 3
    case cosmetics = 4
    case toys = 5
    case videoGames = 6
    case cars = 7
    case undefined = 8
}


extension Category {
    func intValue() -> Int {
        return self.rawValue
    }
}
