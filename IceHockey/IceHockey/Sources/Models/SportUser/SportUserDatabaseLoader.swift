//
//  SportUserDatabaseLoader.swift
//  IceHockey
//
//  Created by  Buxlan on 11/24/21.
//

import Firebase

protocol SnapshotInitiable {
    init?(snapshot: DataSnapshot)
}

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

class SportUserDatabaseLoader: FirebaseDatabaseLoader {
    
    typealias DataType = SportUserDatabaseFlowDataImpl
    
    // MARK: - Properties
    
    let objectIdentifier: String
    
    private var databaseRootPath = "users"
    internal lazy var databaseQuery: DatabaseQuery = {
        FirebaseManager.shared.databaseManager
            .root
            .child(databaseRootPath)
            .child(objectIdentifier)
    }()
    
    // MARK: - Lifecircle
    
    required init(objectIdentifier: String) {
        self.objectIdentifier = objectIdentifier
    }
    
}
