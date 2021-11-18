//
//  FirebaseObjectFactory.swift
//  IceHockey
//
//  Created by  Buxlan on 11/18/21.
//

import Firebase

struct FirebaseObjectFactory {
    
    func create<DataType: FirebaseObject>(objectType: DataType.Type,
                                          from snapshot: DataSnapshot,
                                          with completionHandler: @escaping (DataType?) -> Void)
    -> DataType? {
        
        switch objectType {
        case is SportEvent.Type:
            let factory = SportEventCreatorImpl()
            let handler: (SportEvent?) -> Void = { object in
                let casted = object as? DataType
                completionHandler(casted)
            }
            let object = factory.create(snapshot: snapshot, with: handler) as? DataType
            return object
        case is SportUser.Type:
            let builder = SportUserBuilder(key: snapshot.key)
            let handler: (SportUser?) -> Void = { object in
                let casted = object as? DataType
                completionHandler(casted)
            }
            builder.build(completionHandler: handler)
            let object = builder.getResult() as? DataType
            return object
        default:
            return nil
        }
    }
    
}
