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
}
