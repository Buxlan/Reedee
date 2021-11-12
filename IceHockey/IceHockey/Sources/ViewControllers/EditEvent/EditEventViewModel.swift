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
    var dataSource: SportNews! {
        didSet {
            let imageData = dataSource.imageIDs.map { (imageUid) -> EventDetailPhotoCellModel in
                return EventDetailPhotoCellModel(imageID: imageUid, eventUID: dataSource.uid)
            }
            tableItems = [
                EditEventTitleViewConfigurator(data: nil),
                EditEventInputDateViewConfigurator(data: dataSource.date),
                EditEventTitleTextFieldViewConfigurator(data: dataSource.title),
                EditEventAddPhotoViewConfigurator(data: imageData),
                EditEventTextViewConfigurator(data: dataSource.text),
                EditEventBoldTextViewConfigurator(data: dataSource.boldText),
                EditEventSaveViewConfigurator(data: nil)
            ]
            handler.reloadData()
        }
    }
    weak var delegate: ViewControllerDismissable?
    private var handler: EditEventHandler
    private var tableItems: [TableRow] = []
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
    
    func removeImage(withID imageName: String) {
        dataSource?.removeImage(withName: imageName)
        handler.reloadData()
    }
}
