//
//  FinanceReportsButton.swift
//  TMKTitanFramework
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.02.2022.
//

import UIKit

class FinanceReportsButton: FinanceRouterButton {
    
    init() {
        let image = Asset.newspaper.image
        let title = L10n.Finance.Reports.title
        super.init(title: title, image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
