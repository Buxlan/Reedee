//
//  DetailDocumentTableSectionHeaderViewModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 20.02.2022.
//

import UIKit

struct DetailDocumentTableSectionHeaderViewModel: TableCellModel,
                                                  TintColorable {
    
    var plusAmount: Double
    var minusAmount: Double
    
    var backgroundColor: UIColor = .white
    var textColor: UIColor = Asset.textColor.color
    var tintColor: UIColor = Asset.other1.color
    var font: UIFont = Fonts.Regular.body
    
    init(data: Document) {
        plusAmount = 0.0
        minusAmount = 0.0
        
        data.table.rows.forEach { row in
            switch row.type {
            case .income:
                plusAmount += row.amount
            case .cost:
                minusAmount += row.amount
            }
        }
    }
    
}
