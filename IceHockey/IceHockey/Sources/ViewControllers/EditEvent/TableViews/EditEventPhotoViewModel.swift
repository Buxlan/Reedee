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
    
    private var dataSource: [ContentConfigurator] = []
    
    // MARK: - Lifecircle
    
    // MARK: - Helper functions
    
    mutating func setImageData(data: [EventDetailPhotoCellModel]) {
        dataSource = data.map { (config) -> ContentConfigurator in
            EditEventPhotoCollectionCellConfigurator(data: config)
        }
        let addImageItem = EditEventAddPhotoCollectionCellConfigurator(data: nil)
        dataSource.append(addImageItem)
    }
    
    func item(at indexPath: IndexPath) -> ContentConfigurator {
        assert(indexPath.row >= 0 &&
              indexPath.row < dataSource.count)
        return dataSource[indexPath.row]
    }
    
    var itemsCount: Int {
        dataSource.count
    }
    
}
