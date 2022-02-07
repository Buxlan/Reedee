//
//  FinanceTransactionUploader.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 07.02.2022.
//

import Firebase

class FinanceTransactionUploader {
    
    let databasePart: String = "transactions"
    
    private var databaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager
            .root
            .child(databasePart)
    }
    
    private var uploads: [String: Bool] = [:]
    
    func uploadTransactions(_ transactions: [FinanceTransaction],
                            completionHander: @escaping () -> Void) {
        transactions.forEach { transaction in
            self.uploadTransaction(transaction, completionHander: completionHander)
        }
    }
    
    func uploadTransaction(_ transaction: FinanceTransaction,
                           completionHander: @escaping () -> Void) {
        
        guard FirebaseAuthManager.shared.current != nil else {
            return
        }
        
        var objectRef: DatabaseReference
        var editableTransaction = transaction
        
        if transaction.isNew {
            objectRef = databaseReference.childByAutoId()
            editableTransaction.objectIdentifier = objectRef.ref.key!
        } else {
            objectRef = databaseReference.child(transaction.objectIdentifier)
            
        }
        
        uploads[editableTransaction.objectIdentifier] = true
        
        let data = transaction.encode()
        
        objectRef.setValue(data) { [weak self] (error, ref) in
            guard let self = self else {
                return
            }
            self.uploads[editableTransaction.objectIdentifier] = nil
            defer {
                if self.uploads.isEmpty {
                    completionHander()
                }
            }
            if let error = error {
                log.debug(error)
                return
            }
            guard let objectId = ref.key else {
                log.debug("Transaction \(transaction) not saved ???")
                return
            }
            log.debug("Transaction \(ref.key) succesfully saved")
        }
        
    }
    
}
