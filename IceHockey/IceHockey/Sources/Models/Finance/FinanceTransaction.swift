//
//  FinanceTransaction.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.02.2022.
//

import UIKit

protocol FinanceTransactionProtocol {
    var name: String { get set }
    var number: String  { get set }
    var comment: String  { get set }
    var type: TransactionType  { get set }
    var amount: Double  { get set }
    var date: Date { get set }
    var isActive: Bool { get set }
    
    func encode() -> [String: Any]
}

protocol FinanceTransaction: FirebaseObject, FinanceTransactionProtocol {
}

struct FinanceTransactionImpl: FinanceTransaction {
    var objectIdentifier: String
    var name: String
    var number: String
    var comment: String
    var type: TransactionType
    var amount: Double
    var date: Date
    var isActive: Bool
    
    init(databaseFlowObject: FinanceTransactionDatabaseFlowData = EmptyFinanceTransactionDatabaseFlowData()) {
        self.objectIdentifier = databaseFlowObject.objectIdentifier
        self.name = databaseFlowObject.name
        self.number = databaseFlowObject.number
        self.comment = databaseFlowObject.comment
        self.type = databaseFlowObject.type
        self.amount = databaseFlowObject.amount
        self.date = databaseFlowObject.date
        self.isActive = databaseFlowObject.isActive
    }
    
    func encode() -> [String: Any] {
        
        let dict: [String: Any] = [
            "uid": self.objectIdentifier,
            "name": self.name,
            "number": self.number,
            "comment": self.comment,
            "type": self.type.rawValue,
            "amount": self.amount,
            "date": Int(self.date.timeIntervalSince1970),
            "isActive": self.isActive
        ]
        
        return dict
    }
    
}
