//
//  ImagePickerManager.swift
//  IceHockey
//
//  Created by  Buxlan on 10/22/21.
//

import Foundation
import UIKit

class ImagePickerManager: NSObject,
                          UIImagePickerControllerDelegate,
                          UINavigationControllerDelegate {

    var picker = UIImagePickerController()
    var pickImageCallback: ((UIImage?) -> Void)?
    
    override init() {
        super.init()
        picker.delegate = self
    }
    
    func openCamera(_ presentingViewController: UIViewController,
                    completion: @escaping ((UIImage?) -> Void)) {
        pickImageCallback = completion
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            presentingViewController.present(picker, animated: true, completion: nil)
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Warning", message: "You don't have the camera", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
                return controller
            }()
            presentingViewController.present(alertController, animated: true)
        }
    }
    
    func openGallery(_ presentingViewController: UIViewController,
                     completion: @escaping ((UIImage?) -> Void)) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            pickImageCallback = completion
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            presentingViewController.present(picker, animated: true, completion: nil)
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Warning", message: "Cannot get access to save photos album",
                                                   preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
                return controller
            }()
            completion(nil)
            presentingViewController.present(alertController, animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.pickImageCallback?(nil)
            self.pickImageCallback = nil
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true) {
            guard let image = (info[.editedImage] as? UIImage)?
                    .resizeImage(to: 512, aspectRatio: .square) else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
            self.pickImageCallback?(image)
            self.pickImageCallback = nil
        }
    }    

}
