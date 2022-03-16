//
//  DocumentTable.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.02.2022.
//

protocol DocumentTable {
    var rows: [DocumentTableRow] { get set }
    func encode() -> Array<[String: Any]>
    func getNewRowIndex() -> Int
}

extension DocumentTable {
    func getNewRowIndex() -> Int {
        var maxIndex = 0
        rows.forEach {
            if $0.index > maxIndex {
                maxIndex = $0.index
            }
        }
        maxIndex += 1
        return maxIndex
    }
}

struct EmptyDocumentTable: DocumentTable {
    var rows: [DocumentTableRow] = []
    
    func encode() -> Array<[String : Any]> {
        rows.map {
            $0.encode()
        }
    }
}

//struct DocumentTableImpl<RowType: DocumentTableRow> : DocumentTable {
//    var rows: [DocumentTableRow]
//    
//    init(dict: [String: Any]) {
//        self.rows = dict.compactMap { (key, value) -> RowType? in
//            RowType(key: key, value: value)
//        }
//    }
//}
