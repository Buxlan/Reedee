//
//  FinanceTransaction.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.02.2022.
//

import UIKit

protocol FinanceTransactionProtocol {
    var documentIdentifier: String { get set }
    var documentView: String { get set }
    var name: String { get set }
    var surname: String { get set }
    var number: String  { get set }
    var comment: String  { get set }
    var type: TransactionType  { get set }
    var amount: Double  { get set }
    var date: Date { get set }
    var isActive: Bool { get set }
    
    func encode() -> [String: Any]
    func clone() -> FinanceTransactionProtocol
}

protocol FinanceTransaction: FirebaseObject, FinanceTransactionProtocol {
}

struct FinanceTransactionImpl: FinanceTransaction {
    var objectIdentifier: String
    var documentIdentifier: String
    var name: String
    var surname: String
    var number: String
    var comment: String
    var type: TransactionType
    var amount: Double
    var date: Date
    var isActive: Bool
    var documentView: String
    
    init(databaseFlowObject: FinanceTransactionDatabaseFlowData = EmptyFinanceTransactionDatabaseFlowData()) {
        self.objectIdentifier = databaseFlowObject.objectIdentifier
        self.documentIdentifier = databaseFlowObject.documentIdentifier
        self.name = databaseFlowObject.name
        self.surname = databaseFlowObject.surname
        self.number = databaseFlowObject.number
        self.comment = databaseFlowObject.comment
        self.type = databaseFlowObject.type
        self.amount = databaseFlowObject.amount
        self.date = databaseFlowObject.date
        self.isActive = databaseFlowObject.isActive
        self.documentView = databaseFlowObject.documentView
    }
    
    init(tableRow row: DocumentTableRow) {
        self.objectIdentifier = ""
        self.documentIdentifier = ""
        self.name = row.name
        self.surname = row.surname
        self.number = row.number
        self.comment = row.comment
        self.type = row.type
        self.amount = row.amount
        self.date = row.date
        self.isActive = true
        self.documentView = ""
    }
    
    func encode() -> [String: Any] {
        
        let dict: [String: Any] = [
            "uid": self.objectIdentifier,
            "document": self.documentIdentifier,
            "documentView": self.documentView,
            "name": self.name,
            "surname": self.surname,
            "number": self.number,
            "comment": self.comment,
            "type": self.type.rawValue,
            "amount": self.amount,
            "date": Int(self.date.timeIntervalSince1970),
            "isActive": self.isActive
        ]
        
        return dict
    }
    
    func clone() -> FinanceTransactionProtocol {
        var object = FinanceTransactionImpl()
        object.objectIdentifier = self.objectIdentifier
        object.documentIdentifier = self.documentIdentifier
        object.name = self.name
        object.surname = self.surname
        object.number = self.number
        object.comment = self.comment
        object.type = self.type
        object.amount = self.amount
        object.date = self.date
        object.isActive = self.isActive
        object.documentView = self.documentView
        
        return object
    }
    
}
