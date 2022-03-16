//
//  FinanceTransactionDatabaseFlowData.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.02.2022.
//

import Firebase

protocol FinanceTransactionDatabaseFlowData: FirebaseObject {
    var documentIdentifier: String { get set }
    var documentView: String { get set }
    var type: TransactionType { get set }
    var date: Date { get set }
    var name: String { get set }
    var surname: String { get set }
    var number: String { get set }
    var comment: String { get set }
    var amount: Double { get set }
    var isActive: Bool { get set }
}

struct EmptyFinanceTransactionDatabaseFlowData: FinanceTransactionDatabaseFlowData {
    var documentIdentifier: String = ""
    var documentView: String = ""
    var type: TransactionType = .income
    var date: Date = Date()
    var name: String = ""
    var surname: String = ""
    var number: String = ""
    var comment: String = ""
    var amount: Double = 0.0
    var objectIdentifier: String = ""
    var isActive: Bool = true
}

struct FinanceTransactionDatabaseFlowDataImpl: FinanceTransactionDatabaseFlowData {
    var documentIdentifier: String
    var documentView: String
    var type: TransactionType
    var date: Date
    var name: String
    var surname: String
    var number: String
    var comment: String
    var amount: Double
    var objectIdentifier: String
    var isActive: Bool
    
    init?(snapshot: DataSnapshot) {
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else {
            return nil
        }
        self.init(key: uid, dict: dict)
    }
    
    init(key: String, dict: [String: Any]) {
        self.objectIdentifier = key
        self.documentIdentifier = dict["document"] as? String ?? ""
        self.documentView = dict["documentView"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.surname = dict["surname"] as? String ?? ""
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
