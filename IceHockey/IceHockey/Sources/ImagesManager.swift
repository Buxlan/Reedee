//
//  ImagesManager.swift
//  IceHockey
//
//  Created by  Buxlan on 10/24/21.
//

import UIKit
import Firebase

class ImagesManager {
    
    // MARK: Properties
    
    static let shared = ImagesManager()
    
    private let cache = NSCache<NSString, UIImage>()
    private var uploadTasks: [StorageTask] = []
    
    // MARK: Lifecircle
    
    private init() {
    }
    
}

// MARK: Helper methods
extension ImagesManager {
    
    func getImage(withID imageID: String,
                  path: String,
                  completion handler: @escaping (UIImage?) -> Void) {
        let imageName = self.getImageName(withID: imageID)
        let nskey = imageName as NSString
        if let image = self.cache.object(forKey: nskey) {
            handler(image)
            return
        }
        self.downloadImage(withName: imageName, path: path, completionHandler: handler)        
    }
    
    func getCachedImage(withName imageName: String) -> UIImage? {
        let nskey = imageName as NSString
        return cache.object(forKey: nskey)
    }
    
    func appendToCache(_ image: UIImage, for key: String) {
        let nskey = key as NSString
//        cache.setObject(image, forKey: nskey)
    }
    
    func removeFromCache(imageForKey key: String) {
        let nskey = key as NSString
        cache.removeObject(forKey: nskey)
    }

    private func downloadImage(withName imageName: String,
                               path: String,
                               completionHandler: @escaping (UIImage?) -> Void) {
        let ref = getImageStorageReference(imageName: imageName, path: path)
        let maxSize: Int64 = 1 * 1024 * 1024
        ref.getData(maxSize: maxSize) { [weak self] (data, error) in
            if let error = error {
                print("Download error: \(error)")
                completionHandler(nil)
                return
            }
            if let data = data,
               let image = UIImage(data: data) {
//                self.cache.setObject(image, forKey: (path + "/" + imageName) as NSString)
                completionHandler(image)
                return
            }
            completionHandler(nil)
        }
    }
    
    private func getImageStorageReference(imageName: String, path: String) -> StorageReference {
        let ref = FirebaseManager.shared.storageManager.root
            .child(path)
            .child(imageName)
        return ref
    }
}

extension ImagesManager {
    
    func appendUploadTask(_ task: StorageUploadTask) {
        task.observe(.success) { [weak self] (snapshot) in
            guard let self = self else { return }
            if let index = self.uploadTasks.firstIndex(of: snapshot.task) {
                self.uploadTasks.remove(at: index)
            }
        }
        task.observe(.failure) { [weak self] (snapshot) in
            guard let self = self else { return }
            if let index = self.uploadTasks.firstIndex(of: snapshot.task) {
                self.uploadTasks.remove(at: index)
            }
        }
        uploadTasks.append(task)
        task.resume()
    }
    
    func getImageName(withID imageID: String) -> String {
        return imageID + ".png"
    }
    
}
