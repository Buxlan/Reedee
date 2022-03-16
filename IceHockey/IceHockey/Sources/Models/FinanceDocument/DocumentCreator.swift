//
//  DocumentCreator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.02.2022.
//

import Firebase

import Firebase

class DocumentCreator {
    
    private var builder: FirebaseObjectBuilder?
    
    func create(snapshot: DataSnapshot,
                with completionHandler: @escaping () -> Void)
    -> Document? {
        
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        let type = getType(dict)
        
        switch type {
        case .operation:
            let builder = DocumentBuilder<OperationDocument>(objectIdentifier: uid)
            self.builder = builder
            builder.dict = dict
            builder.build { [weak self] in
                completionHandler()
                self?.builder = nil
            }
            return builder.getResult()
        case .increase:
            let builder = DocumentBuilder<IncreaseDocument>(objectIdentifier: uid)
            self.builder = builder
            builder.dict = dict
            builder.build { [weak self] in
                completionHandler()
                self?.builder = nil
            }
            return builder.getResult()
        case .decrease:
            let builder = DocumentBuilder<DecreaseDocument>(objectIdentifier: uid)
            self.builder = builder
            builder.dict = dict
            builder.build { [weak self] in
                completionHandler()
                self?.builder = nil
            }
            return builder.getResult()
        default:
            return nil
        }
    }
    
    func createOperationDocument(with transactions: [FinanceTransaction])
    -> OperationDocument {
        var databaseData = OperationDocumentDatabaseFlowData()
        var table = EmptyDocumentTable()
        var index = 0
        var increaseAmount: Double = 0.0,
            decreaseAmount: Double = 0.0
        
        let rows: [DocumentTableRow] = transactions.map {
            index += 1
            switch $0.type {
            case .income:
                increaseAmount += $0.amount
            case .cost:
                decreaseAmount += $0.amount
            }
            return OperationDocumentTableRow(transaction: $0, index: index)
        }
        table.rows.append(contentsOf: rows)
        databaseData.table = table
        databaseData.amount = increaseAmount
        databaseData.decreaseAmount = decreaseAmount
        
        var document = OperationDocument(databaseFlowObject: databaseData)
        document.isActive = true
        return document
    }
    
    func makeDatabasePart(from snapshot: DataSnapshot)
    -> DocumentDatabaseFlowData? {
        
        let objectIdentifier = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        return makeDatabasePart(key: objectIdentifier, dict: dict)
    }
    
    func makeDatabasePart(key: String, dict: [String: Any])
    -> DocumentDatabaseFlowData? {
        
        let objectIdentifier = key
        let type = getType(dict)
        switch type {
        case .operation:
            return OperationDocumentDatabaseFlowData(key: objectIdentifier, dict: dict)
        case .increase:
            return IncreaseDocumentDatabaseFlowData(key: objectIdentifier, dict: dict)
        case .decrease:
            return DecreaseDocumentDatabaseFlowData(key: objectIdentifier, dict: dict)
        default:
            return nil
        }
    }
    
    private func getType(_ dict: [String: Any]) -> DocumentType? {
        guard let rawType = dict["type"] as? Int,
              let type = DocumentType(rawValue: rawType) else { return nil }
        return type
    }
    
}

