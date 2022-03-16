//
//  DocumentBuilder.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.02.2022.
//

class DocumentBuilder<DocType: Document>: FirebaseObjectBuilder {
    
    // MARK: - Properties
    
    private let objectIdentifier: String
    var dict: [String: Any]?
    
    private lazy var databasePart: DocumentDatabaseFlowData = {
        var data: DocumentDatabaseFlowData
        switch DocType.self {
        case is OperationDocument.Type:
            data = EmptyDocumentDatabaseFlowData(type: .operation)
        case is IncreaseDocument.Type:
            data = EmptyDocumentDatabaseFlowData(type: .increase)
        case is DecreaseDocument.Type:
            data = EmptyDocumentDatabaseFlowData(type: .decrease)
        default:
            log.debug("DocumentBuilder: unknown document type")
            fatalError()
        }
        
        return data
    }()
    
    private var proxy = DocumentProxy()
    private var activeBuilders: [String: FirebaseObjectBuilder] = [:]
    private var activeLoaders: [String: EventImagesLoader] = [:]
    
    // MARK: - Lifecircle
    
    required init(objectIdentifier: String) {
        self.objectIdentifier = objectIdentifier
    }
    
    deinit {
        print("deinit \(type(of: self))")
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping () -> Void) {
        log.debug("DocumentBuilder: build started")
        guard !objectIdentifier.isEmpty else {
            completionHandler()
            return
        }
        activeLoaders.removeAll()
        activeBuilders.removeAll()
        buildDatabasePart { [weak self] in
            self?.buildTransactions {
                self?.buildLikesInfo {
                    self?.buildStoragePart {
                        guard let self = self else { return }
                        
                        let object = DocType(databaseFlowObject: self.databasePart)
                        self.proxy.object = object
                        completionHandler()
                        self.activeBuilders.removeAll()
                        self.activeLoaders.removeAll()
                        log.debug("DocumentBuilder: build ended")
                    }
                }
            }
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        log.debug("DocumentBuilder buildDatabasePart")
        if let dict = dict,
           let databasePart = DocumentCreator().makeDatabasePart(key: objectIdentifier,
                                                                 dict: dict) {
            self.databasePart = databasePart
        }
        completionHandler()
    }
    
    private func buildStoragePart(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    private func buildLikesInfo(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    private func buildTransactions(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func getResult() -> Document {
        return proxy
    }
    
}

