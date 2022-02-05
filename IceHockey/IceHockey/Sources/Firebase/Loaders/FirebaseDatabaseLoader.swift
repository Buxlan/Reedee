//
//  FirebaseDatabaseLoader.swift
//  IceHockey
//
//  Created by  Buxlan on 12/10/21.
//

import Firebase

enum DatabaseLoadingDataError: Error {
    case notFound
    case other
}

protocol FirebaseDatabaseLoader: FirebaseLoader {
    associatedtype DataType: SnapshotInitiable
    var objectIdentifier: String { get }
    var databaseQuery: DatabaseQuery { get }
    init(objectIdentifier: String)
}

extension FirebaseDatabaseLoader {
    
    func load(completionHandler: @escaping (Result<DataType?, DatabaseLoadingDataError>) -> Void) {
        log.debug("FirebaseDatabaseLoader load: \(self)")
        guard !objectIdentifier.isEmpty else {
            completionHandler(.failure(.other))
            return
        }
        databaseQuery.getData { error, snapshot in
            guard error == nil && !(snapshot.value is NSNull) else {
                completionHandler(.failure(.notFound))
                return
            }
            let object = DataType(snapshot: snapshot)
            completionHandler(.success(object))
        }
    }
}
