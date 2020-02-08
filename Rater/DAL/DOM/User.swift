//
//  User.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 07..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let accountName: String
    let password: String
}
