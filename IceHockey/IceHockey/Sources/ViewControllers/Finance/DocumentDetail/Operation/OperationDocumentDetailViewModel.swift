//
//  OperationDocumentDetailViewModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.02.2022.
//

import Foundation

class OperationDocumentDetailViewModel {
    
    // MARK: - Properties
    
    var document: OperationDocument!
    
    var onRefresh = {}
    
    // MARK: Lifecircle
    
    // MARK: - Hepler functions
    
    func update() {
        onRefresh()
    }
    
}
