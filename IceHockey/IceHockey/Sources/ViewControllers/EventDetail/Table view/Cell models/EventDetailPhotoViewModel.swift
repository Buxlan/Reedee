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
    
    var rows: [TableRow] = []
    
    // MARK: - Lifecircle
    
    init() {
        
    }
    
    // MARK: - Helper functions
    
    mutating func setImageData(_ cellModels: [EventDetailPhotoCellModel]) {
        rows = cellModels.map { (cellModel) -> TableRow in
            self.makeTableRow(cellModel)
        }
    }
    
    func item(at indexPath: IndexPath) -> TableRow {
        guard indexPath.row >= 0,
              indexPath.row < rows.count else {
            fatalError("Wrong index path")
        }
        return rows[indexPath.row]
    }
    
    func makeTableRow(_ cellModel: EventDetailPhotoCellModel) -> TableRow {
        let configurator = EventDetailPhotoCollectionCellConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: configurator).reuseIdentifier, config: configurator, height: UITableView.automaticDimension)
        row.action = {
        }
        return row
    }
    
}
