//
//  OperationDocumentFirebaseSaver.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.02.2022.
//

import Firebase
import Foundation

class OperationDocumentFirebaseSaver {
    
    // MARK: - Properties
    
    typealias DataType = OperationDocument
    internal var object: DataType
    internal var transactionLoader: DocumentTransactionsLoader?
    internal var uploader: FinanceTransactionUploader?
    
    internal var transactionsDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("transactions")
    }
    
    internal var objectsDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("documents")
    }
    
    internal var objectReference: DatabaseReference {
        var ref: DatabaseReference
        if object.isNew {
            ref = objectsDatabaseReference.childByAutoId()
        } else {
            ref = objectsDatabaseReference.child(object.objectIdentifier)
        }
        return ref
    }
    
    private var orderValue: Int {
        // for order purposes
        var dateComponent = DateComponents()
        dateComponent.calendar = Calendar.current
        dateComponent.year = 2024
        guard let templateDate = dateComponent.date else {
            return 0
        }
        let order = Int(templateDate.timeIntervalSince(object.date))
        return order
    }
    
    // MARK: - Lifecircle
    
    init(object: DataType) {
        self.object = object
    }
    
    // MARK: - Helper functions
    
    func save(completionHandler: @escaping (Result<Void, SaveObjectError>) -> Void) {
        guard object.beforeSave() else {
            return completionHandler(.failure(.objectEventError))
        }
        if object.isNew {
            saveNew(completionHandler: completionHandler)
        } else {
            saveExisting(completionHandler: completionHandler)
        }
        object.afterSave()
    }
    
    private func saveNew(completionHandler: @escaping (Result<Void, SaveObjectError>) -> Void) {
        
        saveData(completionHandler: completionHandler)
        
    }
    
    private func saveExisting(completionHandler: @escaping (Result<Void, SaveObjectError>) -> Void) {
        
        saveData(completionHandler: completionHandler)
        
    }
    
    private func prepareTransactionsQuery(documentId: String) -> DatabaseQuery {
        let query = transactionsDatabaseReference
            .queryOrdered(byChild: "document")
            .queryEqual(toValue: documentId)
        
        return query
    }
        
    private func saveData(completionHandler: @escaping (Result<Void, SaveObjectError>) -> Void) {
        
        let dataDict = object.encode()
        
        objectReference.setValue(dataDict) { [weak self] (error, ref) in
            guard let self = self else { return }
            if let error = error {
                completionHandler(.failure(.databaseError(error.localizedDescription)))
                return
            }
            guard let identifier = ref.key
            else {
                completionHandler(.failure(.databaseError(L10n.Error.databaseKeyIsNil)))
                return
            }
            
            self.transactionLoader = DocumentTransactionsLoader(documentIdentifier: identifier)
            self.transactionLoader?.loadKeys(completionHandler: { [weak self] keys in
                guard let self = self else { return }
                
                // remove old transactions
                keys.forEach { key in
                    self.transactionsDatabaseReference
                        .child(key)
                        .removeValue()
                }
                
                if !self.object.isActive {
                    log.debug("OperationDocumentFirebaseSaver saveData success")
                    completionHandler(.success(()))
                    self.uploader = nil
                    self.transactionLoader = nil
                    return
                }
                
                // save new transactions
                
                log.debug("OperationDocumentFirebaseSaver saveData uploading transactions")
                let rows = self.object.table.rows
                let transactions: [FinanceTransaction] = rows.map { row in
                    var transaction = FinanceTransactionImpl(tableRow: row)
                    transaction.documentIdentifier = identifier
                    transaction.documentView = self.object.view
                    return transaction
                }
                self.uploader = FinanceTransactionUploader()
                self.uploader?.uploadTransactions(transactions) { [weak self] error in
                    if let error = error {
                        log.debug("OperationDocumentFirebaseSaver saveData error upload transactions")
                        completionHandler(.failure(.databaseError(error.localizedDescription)))
                        self?.uploader = nil
                        self?.transactionLoader = nil
                        return
                    }
                    log.debug("OperationDocumentFirebaseSaver saveData success")
                    completionHandler(.success(()))
                    self?.uploader = nil
                    self?.transactionLoader = nil
                }
            })
            
        }
        
    }
    
}
