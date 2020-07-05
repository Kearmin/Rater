//
//  ImgurImage.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 07. 05..
//  Copyright © 2020. Jenci. All rights reserved.
//

//   let imgurImage = try? newJSONDecoder().decode(ImgurImage.self, from: jsonData)

import Foundation

// MARK: - ImgurImage
struct ImgurImage: Codable {
    let data: DataClass
    let success: Bool
    let status: Int
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: String
    let title: String
    let description: String?
    let datetime: Int
    let type: String
    let animated: Bool
    let width, height, size, views: Int
    let bandwidth: Int
    let deletehash: String?
    let section: String?
    let link: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case description
        case datetime, type, animated, width, height, size, views, bandwidth, deletehash, section, link
    }
}
