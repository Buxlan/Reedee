//
//  OperationDocumentTableRow.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.02.2022.
//

import Foundation

struct OperationDocumentTableRow: DocumentTableRow {
    
    var index: Int
    var name: String
    var surname: String
    var number: String
    var comment: String
    var type: TransactionType
    var amount: Double
    var date: Date
    var isActive: Bool
    
    init?(key: String, value: Any) {
        guard !key.isEmpty,
              let dict = value as? [String: Any],
              let rawType = dict["type"] as? Int,
              let type = TransactionType(rawValue: rawType) else {
                  return nil
              }
        
        self.type = type
        self.index = dict["index"] as? Int ?? 0
        self.name = dict["name"] as? String ?? ""
        self.surname = dict["surname"] as? String ?? ""
        self.number = dict["number"] as? String ?? ""
        self.comment = dict["comment"] as? String ?? ""
        self.amount = dict["amount"] as? Double ?? 0.0
        self.isActive = dict["isActive"] as? Bool ?? false
        
        self.date = Date()
        if let dateInterval = dict["date"] as? Int {
            self.date = Date(timeIntervalSince1970: TimeInterval(dateInterval))
        }
        
    }
    
    func encode() -> [String : Any] {
        
        let dict: [String: Any] = [
            "index": self.index,
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
}
