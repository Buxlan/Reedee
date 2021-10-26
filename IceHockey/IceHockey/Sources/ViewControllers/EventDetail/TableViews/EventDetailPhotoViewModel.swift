//
//  EventDetailPhotoCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/19/21.
//

import Foundation
import Firebase

struct EventDetailPhotoViewModel {
    
    // MARK: - Properties
    
    private var dataSource: [CellConfigurator] = []
    
    // MARK: - Lifecircle
    
    init() {
        
    }
    
    // MARK: - Helper functions
    
    mutating func setImageData(data: [ImageDataConfiguration]) {
        dataSource = data.map { (config) -> CellConfigurator in
            EventDetailPhotoCollectionCellConfigurator(data: config)
        }
    }
    
    func item(at indexPath: IndexPath) -> CellConfigurator {
        guard indexPath.row >= 0,
              indexPath.row < dataSource.count else {
            fatalError("Wrong index path")
        }
        return dataSource[indexPath.row]
    }
    
    var itemsCount: Int {
        dataSource.count
    }
    
}
