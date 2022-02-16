//
//  FinanceDocumentsButton.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 16.02.2022.
//

import UIKit

class FinanceDocumentsButton: FinanceRouterButton {
    
    init() {
        let image = Asset.docText.image
        let title = L10n.Finance.Reports.title
        super.init(title: title, image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
