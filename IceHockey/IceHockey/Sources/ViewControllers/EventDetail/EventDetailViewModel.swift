//
//  EventDetailViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/18/21.
//

import Firebase
import FirebaseDatabaseUI

class EventDetailViewModel: NSObject {
    
    // MARK: - Properties
    var dataSource: SportEvent? {
        didSet {
            if let data = dataSource {
                let config = data.imageIDs.map { (imageUid) -> ImageDataConfiguration in
                    let imageName = SportEvent.getImageName(forKey: imageUid)
                    return ImageDataConfiguration(name: imageName, eventUID: data.uid)
                }
                tableItems = [EventPhotoCellConfigurator(data: config),
                              EventDetailUsefulButtonsCellConfigurator(data: data),
                              EventDetailTitleCellConfigurator(data: data),
                              EventDetailDescriptionCellConfigurator(data: data),
                              EventDetailBoldTextCellConfigurator(data: data),
                              EventDetailCopyrightCellConfigurator(data: SportTeam.current)
                ]
                delegate?.reloadData()
            }
        }
    }
    private weak var delegate: CellUpdatable?
    private var tableItems: [CellConfigurator] = []
    
    // MARK: Lifecircle
    
    init(delegate: CellUpdatable) {
        super.init()
        self.delegate = delegate
    }    
        
    // MARK: - Hepler functions
}

extension EventDetailViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator = tableItems[indexPath.row]
        return delegate?.configureCell(at: indexPath, configurator: configurator) ?? UITableViewCell()
    }
    
}
