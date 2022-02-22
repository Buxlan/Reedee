//
//  DocumentProxy.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 18.02.2022.
//

import Foundation

class DocumentProxy: Document {
    
    var object: Document?
    
    var objectIdentifier: String {
        get { object?.objectIdentifier ?? "" }
        set { object?.objectIdentifier = newValue }
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
    var type: DocumentType {
        get { object?.type ?? .operation }
        set { object?.type = newValue }
    }
    var isActive: Bool {
        get { object?.isActive ?? false }
        set { object?.isActive = newValue }
    }
    var author: SportUser? {
        get { object?.author }
        set { object?.author = newValue }
    }
    var table: DocumentTable {
        get { object?.table ?? EmptyDocumentTable() }
        set { object?.table = newValue }
    }
    
    func encode() -> [String : Any] {
        if let object = object {
            return object.encode()
        } else {
            return [:]
        }
    }
    
    init() {
    
    }
    
    required init(databaseFlowObject: DocumentDatabaseFlowData) {
        
    }
    
}
