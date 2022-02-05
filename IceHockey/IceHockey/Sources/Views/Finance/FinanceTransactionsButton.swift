//
//  FinanceTransactionsButton.swift
//  TMKTitanFramework
//
//  Created by Sergey Bush bushmakin@outlook.com on 02.02.2022.
//

import UIKit

class FinanceTransactionsButton: FinanceRouterButton {
    
    init() {
        let image = Asset.bookClosed.image
        let title = L10n.Finance.Transactions.title
        super.init(title: title, image: image)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
