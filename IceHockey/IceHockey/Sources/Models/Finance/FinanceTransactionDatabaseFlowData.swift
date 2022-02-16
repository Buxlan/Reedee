//
//  FinanceTransactionDatabaseFlowData.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.02.2022.
//

import Foundation

protocol FinanceTransactionDatabaseFlowData: FirebaseObject {
    var type: TransactionType { get set }
    var date: Date { get set }
    var name: String { get set }
    var number: String { get set }
    var comment: String { get set }
    var amount: Double { get set }
    var isActive: Bool { get set }
}

struct EmptyFinanceTransactionDatabaseFlowData: FinanceTransactionDatabaseFlowData {
    var type: TransactionType = .income
    var date: Date = Date()
    var name: String = ""
    var number: String = ""
    var comment: String = ""
    var amount: Double = 0.0
    var objectIdentifier: String = ""
    var isActive: Bool = true
}

struct FinanceTransactionDatabaseFlowDataImpl: FinanceTransactionDatabaseFlowData {
    var type: TransactionType
    var date: Date
    var name: String
    var number: String
    var comment: String
    var amount: Double
    var objectIdentifier: String
    var isActive: Bool
    
    init(key: String, dict: [String: Any]) {
        self.objectIdentifier = key
        self.name = dict["name"] as? String ?? ""
        self.number = dict["number"] as? String ?? ""
        self.comment = dict["comment"] as? String ?? ""
        self.amount = dict["amount"] as? Double ?? 0.0
        self.isActive = dict["isActive"] as? Bool ?? false
        
        self.type = .income
        if let rawType = dict["type"] as? Int,
           let type = TransactionType(rawValue: rawType) {
            self.type = type
        }
        
        self.date = Date()
        if let dateInterval = dict["date"] as? Int {
            self.date = Date(timeIntervalSince1970: TimeInterval(dateInterval))
        }
    }
    
}
