//
//  TakePictureView.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 06. 25..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isCoordinatorShown: Bool
    @Binding var imageInCoordinator: Image?
    
    init(isShown: Binding<Bool>, image: Binding<Image?>) {
      _isCoordinatorShown = isShown
      _imageInCoordinator = image
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                  didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
       imageInCoordinator = Image(uiImage: unwrapImage)
       isCoordinatorShown = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       isCoordinatorShown = false
    }

}

extension TakePictureView: UIViewControllerRepresentable {

    typealias UIViewControllerType = UIImagePickerController

    func makeUIViewController(context: Context) -> UIImagePickerController {

        let vc = UIImagePickerController()
        vc.delegate = context.coordinator
        vc.sourceType = .camera

        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}



struct TakePictureView {
    
    
    @Binding var isShown: Bool
    @Binding var image: Image?
    
    func makeCoordinator() -> Coordinator {
      return Coordinator(isShown: $isShown, image: $image)
    }

}
