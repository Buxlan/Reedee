//
//  FinanceTransactionBuilder.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.02.2022.
//

class FinanceTransactionBuilder: FirebaseObjectBuilder {
    
    // MARK: - Properties
    
    private let objectIdentifier: String
    var dict: [String: Any]?
    
    private var databasePart: FinanceTransactionDatabaseFlowData = EmptyFinanceTransactionDatabaseFlowData()
    
    private var proxy = FinanceTransactionProxy()
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
        log.debug("FinanceTransactionBuilder build")
        guard !objectIdentifier.isEmpty else {
            completionHandler()
            return
        }
        activeLoaders.removeAll()
        activeBuilders.removeAll()
        buildDatabasePart { [weak self] in
            self?.buildAuthor {
                self?.buildLikesInfo {
                    self?.buildStoragePart {
                        guard let self = self else { return }
                        let object = FinanceTransactionImpl(databaseFlowObject: self.databasePart)
                        self.proxy.object = object
                        completionHandler()
                        self.activeBuilders.removeAll()
                        self.activeLoaders.removeAll()
                    }
                }
            }
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        log.debug("FinanceTransactionBuilder buildDatabasePart")
        if let dict = dict {
            self.databasePart = FinanceTransactionDatabaseFlowDataImpl(key: objectIdentifier, dict: dict)
        }
        completionHandler()
    }
    
    private func buildStoragePart(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    private func buildLikesInfo(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    private func buildAuthor(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func getResult() -> FinanceTransaction {
        return proxy
    }
    
}
