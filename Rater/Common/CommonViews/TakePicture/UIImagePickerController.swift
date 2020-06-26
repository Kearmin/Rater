//
//  UIImagePickerController.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 06. 25..
//  Copyright © 2020. Jenci. All rights reserved.
//

import UIKit
import Foundation

class TakePictureViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

        // print out the image size as a test
        print(image.size)
    }
}
