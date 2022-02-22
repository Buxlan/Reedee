//
//  DetailOperationDocumentHeaderViewModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.02.2022.
//

import UIKit

struct DetailDocumentHeaderViewModel: TableCellModel, TintColorable {
    
    var document: OperationDocument
    
    var backgroundColor: UIColor = .white
    var textColor: UIColor = Asset.textColor.color
    var tintColor: UIColor = Asset.other1.color
    var font: UIFont = Fonts.Regular.body
    
    init(data: OperationDocument) {
        self.document = data
    }
    
}
