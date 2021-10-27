//
//  FirebaseStorageManager.swift
//  IceHockey
//
//  Created by  Buxlan on 10/22/21.
//

import Firebase

struct FirebaseStorageManager {
    
    // MARK: - Properties
    
    let root: StorageReference = Storage.storage().reference()
    
}
