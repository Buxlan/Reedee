//
//  IncreaseDocumentDatabaseFlowData.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 18.02.2022.
//

import Foundation

struct IncreaseDocumentDatabaseFlowData: DocumentDatabaseFlowData {
    
    var objectIdentifier: String
    var type: DocumentType
    var date: Date
    var number: String
    var comment: String
    var amount: Double
    var isActive: Bool
    var author: String
    var table: DocumentTable
    
    init(key: String, dict: [String: Any]) {
        self.objectIdentifier = key
        self.type = .increase
        
        self.number = dict["number"] as? String ?? ""
        self.comment = dict["comment"] as? String ?? ""
        self.amount = dict["amount"] as? Double ?? 0.0
        self.isActive = dict["isActive"] as? Bool ?? false
        self.author = dict["author"] as? String ?? ""
        
        self.date = Date()
        if let dateInterval = dict["date"] as? Int {
            self.date = Date(timeIntervalSince1970: TimeInterval(dateInterval))
        }
        
        table = EmptyDocumentTable()
        if let rowsDict = dict["tableRows"] as? NSArray {
            let rows = rowsDict.compactMap { value -> IncreaseDocumentTableRow? in
                if let dict = value as? [String: Any] {
                    return IncreaseDocumentTableRow(dict: dict)
                }
                return nil
            }
            table.rows = rows
        }
        
    }
    
}
