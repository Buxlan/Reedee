//
//  NetworkManager.swift
//  IceHockey
//
//  Created by  Buxlan on 10/24/21.
//

import UIKit
import Firebase

struct NetworkManager {
    
    // MARK: Properties
    
    static let shared = NetworkManager()
    
    private let cache = NSCache<NSString, UIImage>()
    
    // MARK: Lifecircle
    
    private init() {
    }
    
}

// MARK: Helper methods
extension NetworkManager {
    
    func getImage(withName imageName: String, completion handler: @escaping (UIImage?) -> Void) {
        if let image = cache.object(forKey: imageName as NSString) {
            handler(image)
            return
        }
        downloadImage(withName: imageName, completion: handler)
    }
    
    func appendImageToCache(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    private func downloadImage(withName imageName: String, completion handler: @escaping (UIImage?) -> Void) {
        let ref = getImageStorageReference(imageName: imageName)
        let maxSize: Int64 = 1 * 1024 * 1024
        ref.getData(maxSize: maxSize) { (data, error) in
            if let error = error {
                print("Download error: \(error)")
            }
            if let data = data,
               let image = UIImage(data: data) {
                cache.setObject(image, forKey: imageName as NSString)
                handler(image)
                return
            }
            handler(nil)
        }
    }
    
    private func getImageStorageReference(imageName: String) -> StorageReference {
        let storageReference = FirebaseManager.shared.storageManager.root
        return storageReference.child("events/" + imageName)
    }
}
