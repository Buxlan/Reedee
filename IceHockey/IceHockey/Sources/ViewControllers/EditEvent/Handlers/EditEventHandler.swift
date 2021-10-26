//
//  EditEventHandler.swift
//  IceHockey
//
//  Created by  Buxlan on 10/21/21.
//

import UIKit

protocol MediaPickerDelegate: class {
    func openGallery()
    func makePhoto()
}

protocol EditEventInterface {
    func setDate(_ value: Date)
    func setTitle(_ value: String)
    func setText(_ setTitlevalue: String)
    func setBoldText(_ value: String)
    func appendImage(_ image: UIImage)
    func removeImage(withName imageName: String)
}

protocol EditEventHandlerInterface: CellActionHandler,
                                    CellUpdatable,
                                    MediaPickerDelegate,
                                    EditEventInterface {
    func save()
    
}

class EditEventHandler: NSObject,
                        EditEventHandlerInterface {
    
    // MARK: - Properties
    
    weak var delegate: EditEventHandlerInterface?
    
    // MARK: - Lifecircle
    
    init(delegate: EditEventHandlerInterface) {
        super.init()
        self.delegate = delegate
    }
    
    private override init() {
        super.init()
    }
}

// MARK: - CellUpdatable methods
extension EditEventHandler {
    
    func reloadData() {
        delegate?.reloadData()
    }
    
    func configureCell(at indexPath: IndexPath, configurator: CellConfigurator) -> UITableViewCell {
        delegate?.configureCell(at: indexPath, configurator: configurator) ?? UITableViewCell()
    }
    
}

// MARK: - MediaPickedDelegate methods
extension EditEventHandler {
    
    func openGallery() {
        delegate?.openGallery()
    }
    
    func makePhoto() {
        delegate?.makePhoto()
    }
    
    func save() {
        delegate?.save()
    }
    
    func setDate(_ value: Date) {
        delegate?.setDate(value)
    }
    
    func setTitle(_ value: String) {
        delegate?.setTitle(value)
    }
    
    func setText(_ value: String) {
        delegate?.setText(value)
    }
    
    func setBoldText(_ value: String) {
        delegate?.setBoldText(value)
    }
    
    func removeImage(withName imageName: String) {
        delegate?.removeImage(withName: imageName)
    }
    
    func appendImage(_ image: UIImage) {
        delegate?.appendImage(image)
    }
    
}
