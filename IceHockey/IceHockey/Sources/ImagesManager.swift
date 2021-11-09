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
    
    func getImage(withName imageName: String,
                  path: String,
                  completion handler: @escaping (UIImage?) -> Void) {
        let nskey = imageName as NSString
        if let image = cache.object(forKey: nskey) {
            handler(image)
            return
        }
        downloadImage(withName: imageName, path: path, completion: handler)
    }
    
    func getCachedImage(forName imageName: String) -> UIImage? {
        let nskey = imageName as NSString
        return cache.object(forKey: nskey)
    }
    
    func appendToCache(_ image: UIImage, for key: String) {
        let nskey = key as NSString
        cache.setObject(image, forKey: nskey)
    }
    
    func removeFromCache(imageForKey key: String) {
        let nskey = key as NSString
        cache.removeObject(forKey: nskey)
    }

    private func downloadImage(withName imageName: String, path: String, completion handler: @escaping (UIImage?) -> Void) {
        let ref = getImageStorageReference(imageName: imageName, path: path)
        let maxSize: Int64 = 1 * 1024 * 1024
        ref.getData(maxSize: maxSize) { (data, error) in
            if let error = error {
                print("Download error: \(error)")
                handler(nil)
                return
            }
            if let data = data,
               let image = UIImage(data: data) {
                self.cache.setObject(image, forKey: imageName as NSString)
                handler(image)
                return
            }
            handler(nil)
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
        task.observe(.success) { (snapshot) in
            if let index = self.uploadTasks.firstIndex(of: snapshot.task) {
                self.uploadTasks.remove(at: index)
            }
        }
        task.observe(.failure) { (snapshot) in
            if let index = self.uploadTasks.firstIndex(of: snapshot.task) {
                self.uploadTasks.remove(at: index)
            }
        }
        uploadTasks.append(task)
        task.resume()
    }
    
    static func getImageName(forKey key: String) -> String {
        return key + ".png"
    }
    
}
