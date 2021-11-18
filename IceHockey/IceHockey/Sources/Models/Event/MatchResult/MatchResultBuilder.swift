//
//  MatchResultBuilder.swift
//  IceHockey
//
//  Created by  Buxlan on 11/18/21.
//

class MatchResultBuilder {
    
    // MARK: - Properties
    
    private let key: String
    private let dict: [String: Any]
    
    private var databasePart: MatchResultDatabaseFlowData
    private var storagePart: MatchResultStorageFlowData
    private var author: SportUser
    
    private var completionHandler: (SportEvent?) -> Void = { _ in }
    
    // MARK: - Lifecircle
    
    init(key: String, dict: [String: Any]) {
        self.key = key
        self.dict = dict
        databasePart = DefaultMatchResultDatabaseFlowData()
        storagePart = DefaultMatchResultStorageFlowData()
        author = SportUser()
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping (SportEvent?) -> Void) {
        self.completionHandler = completionHandler
        buildDatabasePart {
            self.buildStoragePart {
                self.buildAuthor()
            }
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        self.databasePart = MatchResultDatabaseFlowDataImpl(key: key, dict: dict)
        completionHandler()
    }
    
    private func buildStoragePart(completionHandler: @escaping () -> Void) {
        guard !databasePart.uid.isEmpty else {
                  self.completionHandler(nil)
                  return
              }
        storagePart = MatchResultStorageFlowDataImpl()
        storagePart.load {
            completionHandler()
        }
    }
    
    private func buildAuthor() {
        let builder = SportUserBuilder(key: databasePart.authorID)
        builder.build { user in
            if let user = user {
                self.author = user
            }
            self.completionHandler(self.getResult())
        }
    }
    
    func getResult() -> MatchResult? {
        let object = MatchResult(databaseFlowObject: databasePart,
                                 storageFlowObject: storagePart,
                                 author: author)
        return object
    }
    
}
