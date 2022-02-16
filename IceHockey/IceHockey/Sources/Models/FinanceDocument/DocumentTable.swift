//
//  DocumentTable.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.02.2022.
//

protocol DocumentTable {
    var rows: [DocumentTableRow] { get set }
}

struct EmptyDocumentTable: DocumentTable {
    var rows: [DocumentTableRow] = []
}

struct DocumentTableImpl<RowType: DocumentTableRow> : DocumentTable {
    var rows: [DocumentTableRow]
    
    init(dict: [String: Any]) {
        self.rows = dict.compactMap { (key, value) -> RowType? in
            RowType(key: key, value: value)
        }
    }
}
