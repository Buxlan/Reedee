//
//  FinanceTransactionProxy.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.02.2022.
//

import Foundation

class FinanceTransactionProxy: FinanceTransaction {
    
    var object: FinanceTransaction?
    
    var objectIdentifier: String {
        get { object?.objectIdentifier ?? "" }
        set { object?.objectIdentifier = newValue }
    }
    var name: String {
        get { object?.name ?? "" }
        set { object?.name = newValue }
    }
    var number: String {
        get { object?.number ?? "" }
        set { object?.number = newValue }
    }
    var comment: String {
        get { object?.comment ?? "" }
        set { object?.comment = newValue }
    }
    var amount: Double {
        get { object?.amount ?? 0.0 }
        set { object?.amount = newValue }
    }
    var date: Date {
        get { object?.date ?? Date() }
        set { object?.date = newValue }
    }
    var type: TransactionType {
        get { object?.type ?? .income }
        set { object?.type = newValue }
    }
    var isActive: Bool {
        get { object?.isActive ?? false }
        set { object?.isActive = newValue }
    }
    
    func encode() -> [String : Any] {
        if let object = object {
            return object.encode()
        } else {
            return [:]
        }
    }
    
}
