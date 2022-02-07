//
//  FinanceTransactionCreator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.02.2022.
//

import Firebase

class FinanceTransactionCreator {
    
    private var builder: FirebaseObjectBuilder?
    
    func create(snapshot: DataSnapshot,
                with completionHandler: @escaping () -> Void)
    -> FinanceTransaction? {
        
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
    
        let builder = FinanceTransactionBuilder(objectIdentifier: uid)
        self.builder = builder
        builder.dict = dict
        builder.build { [weak self] in
            completionHandler()
            self?.builder = nil
        }
        return builder.getResult()
    }
    
    func makeDatabasePart(from snapshot: DataSnapshot)
    -> FinanceTransactionDatabaseFlowData? {
        
        let objectIdentifier = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        return FinanceTransactionDatabaseFlowDataImpl(key: objectIdentifier, dict: dict)
        
    }
    
}
