//
//  ObjectContainer.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 07..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Cloudinary
import SwiftUI
import UIKit

class ObjectContainer {
    
    static var sharedInstace = ObjectContainer()
    
    var user: User?
    var cloudinary: CLDCloudinary
    var token: Token?
    
    private init(){
        let config = CLDConfiguration(cloudName: "dk3njwejr")
        cloudinary = CLDCloudinary(configuration: config)
    }
}
