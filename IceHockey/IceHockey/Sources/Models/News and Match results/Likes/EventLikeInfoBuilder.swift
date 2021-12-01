//
//  EventLikeInfoBuilder.swift
//  IceHockey
//
//  Created by  Buxlan on 11/19/21.
//

import Firebase

class EventLikeInfoBuilder: FirebaseObjectBuilder {
    
    // MARK: - Properties
    
    private let objectIdentifier: String
    private let dict: [String: Any] = [:]
    
    private var databasePart: LikeDatabaseFlowData = DefaultLikeDatabaseFlowData()
    
    private var proxy = EventLikesInfoProxy()
    
    // MARK: - Lifecircle
    
    required init(objectIdentifier: String) {
        self.objectIdentifier = objectIdentifier
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping () -> Void) {
        if objectIdentifier.isEmpty {
            return
        }
        buildDatabasePart { [weak self] in
            guard let self = self else {
                return                
            }
            let object = EventLikesInfoImpl(databaseData: self.databasePart)
            self.proxy.object = object
            completionHandler()
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        let path = type(of: self.databasePart).databaseRootPath
        FirebaseManager.shared.databaseManager
            .root
            .child(path)
            .child(objectIdentifier)
            .getData { [weak self] error, snapshot in
                assert(error == nil)
                if let databasePart = LikeDatabaseFlowDataImpl(snapshot: snapshot) {
                    self?.databasePart = databasePart
                }
                completionHandler()
            }
    }
    
    func getResult() -> EventLikesInfo {
        return proxy
    }
    
}
