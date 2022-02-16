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
    var type: TransactionType?
    var author: SportUser?
    var transactionTable: DocumentTable
    var amount: Double
    
    init() {
        objectIdentifier = ""
        isActive = false
        number = ""
        date = Date()
        comment = ""
        author = nil
        transactionTable = EmptyDocumentTable()
        amount = 0.0
    }
}

struct OperationDocument: Document {
    
    var objectIdentifier: String
    var isActive: Bool
    var number: String
    var date: Date
    var comment: String
    var type: TransactionType?
    var author: SportUser?
    var transactionTable: DocumentTable
    var amount: Double
    
    init(key: String, dict: [String: Any]) {
        self.objectIdentifier = key
        self.number = dict["number"] as? String ?? ""
        self.comment = dict["comment"] as? String ?? ""
        self.amount = dict["amount"] as? Double ?? 0.0
        self.author = dict["author"] as? SportUser ?? nil
        self.isActive = dict["isActive"] as? Bool ?? false
        
        self.date = Date()
        if let dateInterval = dict["date"] as? Int {
            self.date = Date(timeIntervalSince1970: TimeInterval(dateInterval))
        }
        
        self.type = nil
        if let rawType = dict["type"] as? Int,
           let type = TransactionType(rawValue: rawType) {
            self.type = type
        }
        
        self.transactionTable = EmptyDocumentTable()
        if let tableDict = dict["transactionTable"] as? [String: Any] {
           self.transactionTable = DocumentTableImpl<OperationDocumentTableRow>(dict: tableDict)
        }
        
    }
    
    func encode() -> [String: Any] {
        
        let type: Int? = self.type == nil ? nil : self.type!.rawValue
        
        let dict: [String: Any] = [
            "uid": self.objectIdentifier,
            "date": Int(self.date.timeIntervalSince1970),
            "number": self.number,
            "comment": self.comment,
            "type": type as Any,
            "amount": self.amount,
            "transactionTable": self.transactionTable,
            "author": self.author?.objectIdentifier as Any,
            "isActive": self.isActive
        ]
        
        return dict
    }
    
}
