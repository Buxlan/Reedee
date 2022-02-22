//
//  FinanceTransactionUploader.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 07.02.2022.
//

import Firebase

enum FirebaseDataError: Error {
    case common
    case busy
}

class FinanceTransactionUploader {
    
    let databasePart: String = "transactions"
    
    private var databaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager
            .root
            .child(databasePart)
    }
    
    private var uploads: [String: ((FirebaseDataError?) -> Void)] = [:]
    
    private var isLoading: Bool {
        !uploads.isEmpty
    }
    
    func uploadTransactions(_ transactions: [FinanceTransaction],
                            completionHander: @escaping (FirebaseDataError?) -> Void) {
        
        if isLoading {
            log.debug("FinanceTransactionUploader is loading now")
            completionHander(.busy)
            return
        }
        
        let transactionsWithIds: [FinanceTransaction] = transactions.map { transaction in
            
            var editableTransaction = transaction
            
            if transaction.objectIdentifier.isEmpty {
                editableTransaction.objectIdentifier = databaseReference.childByAutoId().ref.key!
            }
            
            let handler: ((FirebaseDataError?) -> Void) = { [weak self] error in
                guard let self = self else {
                    completionHander(error)
                    return
                }
                
                guard error == nil else {
                    self.uploads[editableTransaction.objectIdentifier] = nil
                    completionHander(error)
                    return
                }
                
                self.uploads[editableTransaction.objectIdentifier] = nil
                completionHander(nil)
            }
            
            uploads[editableTransaction.objectIdentifier] = handler
            
            return editableTransaction
        }
        
        transactionsWithIds.forEach { transaction in
            self.uploadTransaction(transaction, completionHander: completionHander)
        }
    }
    
    private func uploadTransaction(_ transaction: FinanceTransaction,
                           completionHander: @escaping (FirebaseDataError?) -> Void) {
        
        guard FirebaseAuthManager.shared.current != nil else {
            completionHander(.common)
            return
        }
        
        let objectRef = databaseReference.child(transaction.objectIdentifier)
        let data = transaction.encode()
        
        objectRef.setValue(data) { [weak self] (error, ref) in
            guard let self = self else {
                completionHander(nil)
                return
            }
            self.uploads[transaction.objectIdentifier] = nil
            defer {
                if self.uploads.isEmpty {
                    completionHander(nil)
                }
            }
            if let error = error {
                completionHander(.common)
                log.debug(error)
                return
            }
            guard let objectId = ref.key else {
                completionHander(.common)
                log.debug("Transaction \(transaction) not saved ???")
                return
            }
            completionHander(nil)
            log.debug("Transaction \(objectId) succesfully saved")
        }
        
    }
    
}
