//
//  EventDetailPhotoCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/19/21.
//

import Foundation
import Firebase

struct EventDetailPhotoCellModel {
    
    // MARK: - Properties
    
    var images: [String] = [] {
        didSet {
            dataSource = images.map { (name) -> CellConfigurator in
                EventDetailPhotoCollectionCellConfigurator(data: name)
            }
        }
    }
    private var dataSource: [CellConfigurator] = []
    
    // MARK: - Lifecircle
    
    init() {
        
    }
    
    // MARK: - Helper functions
    
    func item(at indexPath: IndexPath) -> CellConfigurator {
        guard indexPath.row >= 0,
              indexPath.row < dataSource.count else {
            fatalError("Wrong index path")
        }
        return dataSource[indexPath.row]
    }
    
}
