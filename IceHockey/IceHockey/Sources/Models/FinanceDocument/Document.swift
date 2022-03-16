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
    var type: DocumentType  { get set }
    var author: SportUser? { get set }
    var amount: Double { get set }
    
    var view: String { get }
    
    var table: DocumentTable { get set }
    
    init(databaseFlowObject: DocumentDatabaseFlowData)
    func encode() -> [String: Any]
    
    // events
    func beforeSave() -> Bool
    func onSave()
    func afterSave()
}

extension Document {
    
    var view: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let formattedDate = dateFormatter.string(from: date)
        
        var typeStr = ""
        switch type {
        case .operation:
            typeStr = L10n.Document.Operation.title
        case .increase:
            typeStr = L10n.Document.Increase.title
        case .decrease:
            typeStr = L10n.Document.Decrease.title
        }
        
        return "\(typeStr) \(L10n.Common.numberSymbol)\(number) \(L10n.Common.at) \(formattedDate)"
    }
    
    func encode() -> [String: Any] {
        return [:]
    }
    
    func beforeSave() -> Bool {
        return true
    }
    
    func onSave() {
        
    }
    
    func afterSave() {
        
    }
    
}

