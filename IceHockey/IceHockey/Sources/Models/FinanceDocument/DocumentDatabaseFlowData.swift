//
//  DocumentDatabaseFlowData.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 18.02.2022.
//

import Foundation

protocol DocumentDatabaseFlowData: FirebaseObject {
    var type: DocumentType { get set }
    var date: Date { get set }
    var number: String { get set }
    var comment: String { get set }
    var amount: Double { get set }
    var isActive: Bool { get set }
    var author: String { get set }
    var table: DocumentTable { get set }
}

struct EmptyDocumentDatabaseFlowData: DocumentDatabaseFlowData {
    
    var objectIdentifier: String
    var isActive: Bool
    var number: String
    var date: Date
    var comment: String
    var type: DocumentType
    var amount: Double
    var author: String
    
    var table: DocumentTable
    
    init(type: DocumentType) {
        objectIdentifier = ""
        isActive = false
        number = ""
        date = Date()
        comment = ""
        self.type = type
        author = ""
        amount = 0.0
        table = EmptyDocumentTable()
        author = ""
    }
    
}
