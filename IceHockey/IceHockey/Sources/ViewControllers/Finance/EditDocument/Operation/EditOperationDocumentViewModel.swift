//
//  EditOperationDocumentViewModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.03.2022.
//

import Foundation
import RxCocoa
import RxSwift

class EditOperationDocumentViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    var document: OperationDocument
    var saver: OperationDocumentFirebaseSaver?
    
    var uiRefreshHandler: () -> Void = {}
    
    let statusRelay = BehaviorRelay<Status?>(value: nil)
    let disposeBag = DisposeBag()
    
    // MARK: Lifecircle
    
    required init() {
        document = OperationDocument(databaseFlowObject: OperationDocumentDatabaseFlowData())
        document.isActive = true
    }
    
    // MARK: - Hepler functions
    
    func save() {
        saver = OperationDocumentFirebaseSaver(object: document)
        saver?.save { [weak self] result in
            switch result {
            case .success:
                log.debug("Document saved!")
                self?.saver = nil
                DocumentCoordinator.shared.goToDocumentListFromDocumentEditing()
            case .failure(let error):
                log.debug("Document saver error \(error.localizedDescription)")
//                assertionFailure()
                self?.statusRelay.accept(.alert(L10n.Common.error, error.localizedDescription, .ok))
                self?.saver = nil
            }
        }
    }
    
    func deleteRow(_ row: DocumentTableRow) {
        let index = document.table.rows.firstIndex { $0.index == row.index }
        guard let index = index else {
            assertionFailure()
            return
        }
        document.table.rows.remove(at: index)
        updateInterface()
    }
    
    func updateData() {
        updateInterface()
    }
    
}
