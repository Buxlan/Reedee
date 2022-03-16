//
//  DocumentTableRow.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.02.2022.
//

import Foundation

protocol DocumentTableRow {
    var index: Int { get set }
    
    var name: String { get set }
    var surname: String { get set }
    var number: String  { get set }
    var comment: String  { get set }
    var type: TransactionType  { get set }
    var amount: Double  { get set }
    var date: Date { get set }
    
    func encode() -> [String: Any]
    
    init(dict: [String: Any])
}

struct EmptyDocumentTableRow: DocumentTableRow {
    var index: Int
    var name: String
    var surname: String
    var number: String
    var comment: String
    var type: TransactionType
    var amount: Double
    var date: Date
    
    init(dict: [String : Any]) {
        self.init(type: .income)
    }
    
    init(type: TransactionType) {
        
        self.index = 0
        self.name = ""
        self.surname = ""
        self.number = ""
        self.comment = ""
        self.amount = 0.0
        
        self.type = type
        self.date = Date()
        
    }
    
    func encode() -> [String : Any] {
        return [:]
    }
    
}
