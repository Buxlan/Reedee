//
//  DocumentTransactionsLoader.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.03.2022.
//

import Firebase

class DocumentTransactionsLoader {
    
    // MARK: - Properties
    
    typealias DataType = FinanceTransactionDatabaseFlowData
    typealias DataTypeImpl = FinanceTransactionDatabaseFlowDataImpl
    
    var isLoading: Bool {
        print("Loading handlers count: \(loadings.count)")
        return !loadings.isEmpty
    }
    
    private var documentIdentifier: String
    private var databaseRootPath = "transactions"
    
    private var loadings: [String: (FinanceTransactionCreator, () -> Void)] = [:]
    
    // MARK: - Lifecircle
    
    init(documentIdentifier: String) {
        self.documentIdentifier = documentIdentifier
    }
    
    deinit {
        log.debug("deinit DocumentTransactionsLoader")
    }
    
    // MARK: - Helper methods
    
    private func prepareQuery() -> DatabaseQuery {
        var query: DatabaseQuery
        query = FirebaseManager.shared.databaseManager
            .root
            .child(databaseRootPath)
            .queryOrdered(byChild: "document")
            .queryEqual(toValue: documentIdentifier)
        
        return query
    }
    
    func load(completionHandler: @escaping ([DataType]) -> Void) {
        guard !documentIdentifier.isEmpty else {
            completionHandler([])
            return
        }
        prepareQuery().getData { error, snapshot in
            guard let snapshot = snapshot else {
                assertionFailure("Snapshot is nil")
                return
            }
            assert(error == nil && !(snapshot.value is [String: Any]))
            guard let dict = snapshot.value as? [String: Any] else {
                completionHandler([])
                return
            }
            let objects: [DataType] = dict.compactMap { (key, value) in
                guard let value = value as? [String: Any] else { return nil }
                return DataTypeImpl(key: key, dict: value)
            }
            completionHandler(objects)
        }
    }
    
    func loadKeys(completionHandler: @escaping ([String]) -> Void) {
        guard !documentIdentifier.isEmpty else {
            completionHandler([])
            return
        }
        prepareQuery().getData { error, snapshot in
            assert(error == nil)
            guard let snapshot = snapshot else {
                assertionFailure()
                return
            }
            guard let dict = snapshot.value as? [String: Any] else {
                completionHandler([])
                return
            }
            let objects: [String] = dict.map { (key, _) in
                key
            }
            completionHandler(objects)
        }
    }
    
}
