//
//  FirebaseObjectRemover.swift
//  IceHockey
//
//  Created by  Buxlan on 10/29/21.
//

import Foundation

enum FirebaseRemoveError: Error {
    case dataMismatch
    case storageError
    case databaseError
}

protocol FirebaseObjectRemover {
    var object: FirebaseObject { get }
    func remove() throws
}
