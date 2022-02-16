//
//  DocumentTableRow.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.02.2022.
//

import Foundation

protocol DocumentTableRow: FinanceTransactionProtocol {
    var index: Int { get set }
    init?(key: String, value: Any)
}
