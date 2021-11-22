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
    private var author: SportUser?
    private var likesInfo = EventLikesInfo()
    private var viewsInfo = EventViewsInfo()
    
    private var completionHandler: (SportEvent?) -> Void = { _ in }
    
    // MARK: - Lifecircle
    
    init(key: String, dict: [String: Any]) {
        self.key = key
        self.dict = dict
        databasePart = DefaultMatchResultDatabaseFlowData()
        storagePart = DefaultMatchResultStorageFlowData()
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping (SportEvent?) -> Void) {
        self.completionHandler = completionHandler
        buildDatabasePart {
            self.buildAuthor {
                self.buildLikesInfo {
                    self.buildStoragePart()
                }
            }
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        self.databasePart = MatchResultDatabaseFlowDataImpl(key: key, dict: dict)
        completionHandler()
    }
    
    private func buildStoragePart() {
        guard !databasePart.objectIdentifier.isEmpty else {
                  self.completionHandler(nil)
                  return
              }
        storagePart = MatchResultStorageFlowDataImpl()
        storagePart.load {
            self.completionHandler(self.getResult())
        }
    }
    
    private func buildLikesInfo(completionHandler: @escaping () -> Void) {
        let builder = EventLikeInfoBuilder(key: key)
        builder.build { likesInfo in
            if let likesInfo = likesInfo {
                self.likesInfo = likesInfo
            }
            completionHandler()
        }
    }
    
    private func buildAuthor(completionHandler: @escaping () -> Void) {
        let builder = SportUserBuilder(key: databasePart.authorID)
        builder.build { user in
            if let user = user {
                self.author = user
            }
            completionHandler()
        }
    }
    
    func getResult() -> MatchResult? {
        let object = MatchResult(databaseFlowObject: databasePart,
                                 storageFlowObject: storagePart,
                                 author: author,
                                 likesInfo: likesInfo,
                                 viewsInfo: viewsInfo)
        return object
    }
    
}
