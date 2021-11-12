//
//  EditEventPhotoCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/23/21.
//

import Foundation

struct EditEventPhotoViewModel {
    
    // MARK: - Properties
    var handler: EditEventHandler?
    
    private var dataSource: [CellConfigurator] = []
    
    // MARK: - Lifecircle
    
    // MARK: - Helper functions
    
    mutating func setImageData(data: [EventDetailPhotoCellModel]) {
        guard let handler = handler else {
            return
        }
        dataSource = data.map { (config) -> CellConfigurator in
            EditEventPhotoCollectionCellConfigurator(data: config, handler: handler)
        }
        let addImageItem = EditEventAddPhotoCollectionCellConfigurator(data: nil, handler: handler)
        dataSource.append(addImageItem)
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
