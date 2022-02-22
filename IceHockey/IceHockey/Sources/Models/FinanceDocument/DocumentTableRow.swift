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
    var number: String  { get set }
    var comment: String  { get set }
    var type: TransactionType  { get set }
    var amount: Double  { get set }
    var date: Date { get set }
    
    func encode() -> [String: Any]
    
    init(dict: [String: Any])
}
