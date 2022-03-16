//
//  EditOperationDocumentViewModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.03.2022.
//

import Foundation

class EditOperationDocumentViewModel {
    
    // MARK: - Properties
    
    var document: OperationDocument
    var saver: OperationDocumentFirebaseSaver?
    
    var onRefresh = {}
    
    // MARK: Lifecircle
    
    init() {
        document = OperationDocument(databaseFlowObject: OperationDocumentDatabaseFlowData())
        document.isActive = true
    }
    
    // MARK: - Hepler functions
    
    func update() {
        onRefresh()
    }
    
    func save() {
        saver = OperationDocumentFirebaseSaver(object: document)
        saver?.save { [weak self] error in
            guard error == nil else {
                log.debug("Document saver error \(error)")
//                assertionFailure()
                self?.saver = nil
                return
            }
            log.debug("Document saved!")
            self?.saver = nil
            DocumentCoordinator.shared.goToDocumentListFromDocumentEditing()
        }
    }
    
    func deleteRow(_ row: DocumentTableRow) {
        let index = document.table.rows.firstIndex { $0.index == row.index }
        guard let index = index else {
            assertionFailure()
            return
        }
        document.table.rows.remove(at: index)
        onRefresh()
    }
    
}
