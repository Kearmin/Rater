//
//  ProductDetail.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 08. 16..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation

struct ProductDetail: Codable {
    let producer: String
    let barcode: String
    let id: Int
    let ratings: [RatingDetail]
    let average: Double
    let uploaderId: Int
    let name: String
    let description: String
    let imageUrl: URL?
}

struct RatingDetail: Codable {
    let id: Int
    let rating: Int
    let text: String
    let title: String
    let userName: String
    let userId: Int
}
