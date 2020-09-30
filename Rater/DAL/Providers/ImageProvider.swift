//
//  ImageProvider.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 07. 04..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import SwiftUI
import Cloudinary
import Combine


class ImageProvider {

    static func saveImage(_ image: UIImage) -> AnyPublisher<URL, Error> {
        
        let preset = "nmdxvdgn"
        let passthroughSubject = PassthroughSubject<URL, Error>()
        
        let data = image.jpegData(compressionQuality: 0.5)!
        let _ = ObjectContainer.sharedInstace.cloudinary.createUploader().upload(data: data, uploadPreset: preset) { response, error in
            
            if let response = response {
                if let urlString = response.url {
                    
                    if let url = URL(string: urlString) {
                        passthroughSubject.send(url)
                    } else {
                        passthroughSubject.send(completion: .failure(AppError.undefined))
                    }
                }
                if error != nil {
                    passthroughSubject.send(completion: .failure(AppError.undefined))
                }
            }
        }
        return passthroughSubject.eraseToAnyPublisher()
    }
}
