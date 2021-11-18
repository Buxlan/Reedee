//
//  EventLikeInfoBuilder.swift
//  IceHockey
//
//  Created by  Buxlan on 11/19/21.
//

import Firebase

class EventLikeInfoBuilder {
    
    // MARK: - Properties
    
    private let key: String
    private let dict: [String: Any] = [:]
    
    private var databasePart: LikeDatabaseFlowData = DefaultLikeDatabaseFlowData()
    private var completionHandler: (EventLikesInfo?) -> Void = { _ in }
    
    // MARK: - Lifecircle
    
    init(key: String) {
        self.key = key
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping (EventLikesInfo?) -> Void) {
        if key.isEmpty {
            return
        }
        self.completionHandler = completionHandler
        buildDatabasePart {
            self.completionHandler(self.getResult())
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        let path = type(of: self.databasePart).databaseRootPath
        FirebaseManager.shared.databaseManager
            .root
            .child(path)
            .child(key)
            .getData { error, snapshot in
                assert(error == nil)
                if let databasePart = LikeDatabaseFlowDataImpl(snapshot: snapshot) {
                    self.databasePart = databasePart
                }
                completionHandler()
            }
    }
    
    func getResult() -> EventLikesInfo? {
        let object = EventLikesInfo(count: databasePart.count,
                                   isLiked: databasePart.isLiked)
        return object
    }
    
}
