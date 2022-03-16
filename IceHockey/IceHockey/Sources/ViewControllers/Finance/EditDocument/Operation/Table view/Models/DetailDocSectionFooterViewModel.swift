//
//  DetailDocSectionFooterViewModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 09.03.2022.
//

import UIKit

struct DetailDocSectionFooterViewModel: TableCellModel,
                                        TintColorable {
    
    var amount: Double
    let type: TransactionType
    
    var backgroundColor: UIColor = .white
    var textColor: UIColor = Asset.textColor.color
    var tintColor: UIColor = Asset.other1.color
    var font: UIFont = Fonts.Regular.body
    
    init(data: Document, type: TransactionType) {
        amount = 0.0
        self.type = type
        
        data.table.rows.forEach { row in
            if row.type == type {
                amount += row.amount
            }
        }
    }
    
}
