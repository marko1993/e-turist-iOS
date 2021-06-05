//
//  ImagePickerController.swift
//  eTurist
//
//  Created by Marko on 04.06.2021..
//

import UIKit

class ImagePickerController: BaseViewController {
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePicker()
    }
    
    private func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }
    
    func onImageSelected(image: UIImage) {
        
    }
    
    func presentImagePicker() {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}

extension ImagePickerController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            onImageSelected(image: image)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
