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
    func deleteImage(withName imageName: String)
}

protocol EditEventHandlerInterface: CellActionHandler,
                                    CellUpdatable,
                                    UITextViewDelegate,
                                    UITextFieldDelegate,
                                    MediaPickerDelegate {
    
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

// MARK: - UITextFieldDelegate methods
extension EditEventHandler {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        delegate?.textFieldDidEndEditing?(textField, reason: reason)
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
    
    func deleteImage(withName imageName: String) {
        delegate?.deleteImage(withName: imageName)
    }
    
}
