//
//  OperationDocumentFirebaseSaver.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.02.2022.
//

import Firebase

class OperationDocumentFirebaseSaver {
    
    // MARK: - Properties
    
    typealias DataType = OperationDocument
    internal var object: DataType
    
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
    
    func save(completionHandler: @escaping (SaveObjectError?) -> Void) {
        if object.isNew {
            saveNew(completionHandler: completionHandler)
        } else {
            saveExisting(completionHandler: completionHandler)
        }
    }
    
    func saveNew(completionHandler: @escaping (SaveObjectError?) -> Void) {
        
        saveData(completionHandler: completionHandler)
        
    }
    
    func saveExisting(completionHandler: @escaping (SaveObjectError?) -> Void) {
        
        saveData(completionHandler: completionHandler)
        
    }
        
    private func saveData(completionHandler: @escaping (SaveObjectError?) -> Void) {
        
        let dataDict = object.encode()
        objectReference.setValue(dataDict) { [weak self] (error, ref) in
            
            guard let self = self,
                  error == nil,
                  ref.key != nil
            else {
                completionHandler(.databaseError)
                return
            }
            
            log.debug("OperationDocumentFirebaseSaver saveData uploading transactions")
            let transactions = self.object.table.rows.map { row in
                FinanceTransactionImpl(tableRow: row)
            }
            let uploader = FinanceTransactionUploader()
            uploader.uploadTransactions(transactions) { error in
                guard error == nil else {
                    log.debug("OperationDocumentFirebaseSaver saveData error upload transactions")
                    completionHandler(.databaseError)
                    return
                }
                log.debug("OperationDocumentFirebaseSaver saveData success")
                completionHandler(nil)
            }
        }
        
    }
    
}
