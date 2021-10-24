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
    
    var imagesNames: [String] = [] {
        didSet {
            guard let handler = handler else {
                return
            }
            dataSource = imagesNames.map { (name) -> CellConfigurator in
                EditEventPhotoCollectionCellConfigurator(data: name, handler: handler)
            }
            let addImageItem = EditEventAddPhotoCollectionCellConfigurator(data: nil, handler: handler)
            dataSource.append(addImageItem)
        }
    }
    private var dataSource: [CellConfigurator] = []
    
    // MARK: - Lifecircle
    
    // MARK: - Helper functions
    
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
