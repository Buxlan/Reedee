//
//  EditEventViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/20/21.
//

import Firebase
import FirebaseDatabaseUI

class EditEventViewModel: NSObject {
    
    // MARK: - Properties
    var dataSource: SportEvent? {
        didSet {
            if let data = dataSource {
                let imageData = data.imageIDs.map { (imageUid) -> ImageDataConfiguration in
                    let imageName = SportEvent.getImageName(forKey: imageUid)
                    return ImageDataConfiguration(name: imageName, eventUID: data.uid)
                }
                tableItems = [
                    EditEventTitleCellConfigurator(data: nil, handler: handler),
                    EditEventInputDateCellConfigurator(data: data.date, handler: handler),
                    EditEventTitleTextFieldCellConfigurator(data: data.title, handler: handler),
                    EditEventAddPhotoCellConfigurator(data: imageData, handler: handler),
                    EditEventTextCellConfigurator(data: data.text, handler: handler),
                    EditEventBoldTextCellConfigurator(data: data.boldText, handler: handler),                    
                    EditEventSaveCellConfigurator(data: nil, handler: handler)
                ]
                handler.reloadData()
            }
        }
    }
    weak var delegate: ViewControllerDismissable?
    private var handler: EditEventHandler
    private var tableItems: [CellConfigurator] = []
    private var images: [UIImage] = []
    
    // MARK: Lifecircle
    
    init(handler: EditEventHandler) {
        self.handler = handler
        super.init()
    }
        
    // MARK: - Hepler functions    
    
}

extension EditEventViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator = tableItems[indexPath.row]
        return handler.configureCell(at: indexPath, configurator: configurator)
    }
    
}

extension EditEventViewModel {
    
    func save() {
        guard let dataSource = dataSource else {
            return
        }
        do {
            try dataSource.save()
        } catch {
            print(error)
        }
        delegate?.dismiss(animated: true)
    }
}

extension EditEventViewModel: EditEventInterface {
    
    func setDate(_ value: Date) {
        dataSource?.date = value
    }
    
    func setTitle(_ value: String) {
        dataSource?.title = value
    }
    
    func setText(_ value: String) {
        dataSource?.text = value
    }
    
    func setBoldText(_ value: String) {
        dataSource?.boldText = value
    }
        
    func appendImage(_ image: UIImage) {
        dataSource?.appendImage(image)
        handler.reloadData()
    }
    
    func removeImage(withName imageName: String) {
        dataSource?.removeImage(withName: imageName)
        handler.reloadData()
    }
}
