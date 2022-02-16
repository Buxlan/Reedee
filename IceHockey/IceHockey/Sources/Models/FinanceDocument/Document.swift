//
//  Document.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.02.2022.
//

import UIKit

protocol Document: FirebaseObject {
    var isActive: Bool { get set }
    var number: String { get set }
    var date: Date  { get set }
    var comment: String  { get set }
    var type: TransactionType?  { get set }
    var author: SportUser? { get set }
    var amount: Double { get set }
    var transactionTable: DocumentTable { get set }
    
    func encode() -> [String: Any]
}

extension Document {
    func encode() -> [String: Any] {
        return [:]
    }
}

