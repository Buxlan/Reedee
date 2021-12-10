//
//  FirebaseDatabaseLoader.swift
//  IceHockey
//
//  Created by  Buxlan on 12/10/21.
//

import Firebase

protocol FirebaseDatabaseLoader: FirebaseLoader {
    associatedtype DataType: SnapshotInitiable
    var objectIdentifier: String { get }
    var databaseQuery: DatabaseQuery { get }
    init(objectIdentifier: String)
}

extension FirebaseDatabaseLoader {
    
    func load(completionHandler: @escaping (DataType?) -> Void) {
        guard !objectIdentifier.isEmpty else {
            completionHandler(nil)
            return
        }
        databaseQuery.getData { error, snapshot in
            assert(error == nil && !(snapshot.value is NSNull))
            let object = DataType(snapshot: snapshot)
            completionHandler(object)
        }
    }
}
