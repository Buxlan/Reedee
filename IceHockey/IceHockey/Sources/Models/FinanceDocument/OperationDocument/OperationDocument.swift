//
//  OperationDocument.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.02.2022.
//

import Foundation

struct EmptyOperationDocument: Document {
    
    var objectIdentifier: String
    var isActive: Bool
    var number: String
    var date: Date
    var comment: String
    var type: DocumentType
    var author: SportUser?
    var table: DocumentTable
    var amount: Double
    
    init() {
        objectIdentifier = ""
        isActive = false
        number = ""
        date = Date()
        comment = ""
        author = nil
        table = EmptyDocumentTable()
        amount = 0.0
        type = .operation
    }
    
    init(databaseFlowObject: DocumentDatabaseFlowData) {
        self.init()
    }
    
}

struct OperationDocument: Document {
    
    var objectIdentifier: String
    var isActive: Bool
    var number: String
    var date: Date
    var comment: String
    var type: DocumentType
    var author: SportUser?
    var amount: Double
    
    var table: DocumentTable
    
    init(databaseFlowObject: DocumentDatabaseFlowData) {
        guard let databaseFlowObject = databaseFlowObject as? OperationDocumentDatabaseFlowData else {
            log.debug("OperationDocument: cant cast databaseFlowObject" )
            fatalError()
        }
        self.objectIdentifier = databaseFlowObject.objectIdentifier
        self.isActive = databaseFlowObject.isActive
        self.number = databaseFlowObject.number
        self.date = databaseFlowObject.date
        self.comment = databaseFlowObject.comment
        self.type = .operation
        self.author = nil
        self.amount = databaseFlowObject.amount
        self.table = databaseFlowObject.table
    }
    
//    init(key: String, dict: [String: Any]) {
//        self.objectIdentifier = key
//        self.type = .operation
//
//        self.number = dict["number"] as? String ?? ""
//        self.comment = dict["comment"] as? String ?? ""
//        self.amount = dict["amount"] as? Double ?? 0.0
//        self.author = dict["author"] as? SportUser ?? nil
//        self.isActive = dict["isActive"] as? Bool ?? false
//
//        self.date = Date()
//        if let dateInterval = dict["date"] as? Int {
//            self.date = Date(timeIntervalSince1970: TimeInterval(dateInterval))
//        }
//
//        self.table = EmptyDocumentTable()
//        if let tableDict = dict["transactionTable"] as? [String: Any] {
//           self.table = DocumentTableImpl<OperationDocumentTableRow>(dict: tableDict)
//        }
//        
//    }
    
    func encode() -> [String: Any] {
        
        let dict: [String: Any] = [
            "uid": self.objectIdentifier,
            "date": Int(self.date.timeIntervalSince1970),
            "number": self.number,
            "comment": self.comment,
            "type": self.type.rawValue,
            "amount": self.amount,
            "transactionTable": self.table,
            "author": self.author?.objectIdentifier as Any,
            "isActive": self.isActive
        ]
        
        return dict
    }
    
}
