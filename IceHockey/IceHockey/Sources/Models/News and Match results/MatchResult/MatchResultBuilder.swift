//
//  MatchResultBuilder.swift
//  IceHockey
//
//  Created by  Buxlan on 11/18/21.
//

class MatchResultBuilder: FirebaseObjectBuilder {
    
    // MARK: - Properties
    
    private let objectIdentifier: String
    var dict: [String: Any]?
    
    private var databasePart: MatchResultDatabaseFlowData = EmptyMatchResultDatabaseFlowData()
    private var storagePart: StorageFlowData = EmptyStorageFlowData()
    private var author: SportUser?
    private var likesInfo: EventLikesInfo = EventLikesInfoImpl.empty
    private var viewsInfo: EventViewsInfo = EventViewsInfoImpl.empty
    
    private var proxy = MatchResultProxy()
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
        guard !objectIdentifier.isEmpty else {
            completionHandler()
            return
        }
        activeBuilders.removeAll()
        buildDatabasePart { [weak self] in
            self?.buildAuthor {
                self?.buildLikesInfo {
                    self?.buildStoragePart {
                        guard let self = self else {
                            return
                        }
                        let object = MatchResultImpl(databaseFlowObject: self.databasePart,
                                                     storageFlowObject: self.storagePart,
                                                     author: self.author,
                                                     likesInfo: self.likesInfo,
                                                     viewsInfo: self.viewsInfo)
                        self.proxy.event = object
                        completionHandler()
                        self.activeBuilders.removeAll()
                        self.activeLoaders.removeAll()
                    }
                }
            }
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        if let dict = dict {
            self.databasePart = MatchResultDatabaseFlowDataImpl(key: objectIdentifier, dict: dict)
        }
        // 20.11.21 NEED DEVELOP!
        // 01.12.21 But what to develop? I've forgotten
        completionHandler()
    }
    
    private func buildStoragePart(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    private func buildLikesInfo(completionHandler: @escaping () -> Void) {
        let builder = EventLikeInfoBuilder(objectIdentifier: objectIdentifier)
        activeBuilders["LikesInfoBuilder"] = builder
        builder.build {
            completionHandler()
        }
        likesInfo = builder.getResult()
    }
    
    private func buildAuthor(completionHandler: @escaping () -> Void) {
        let builder = SportUserBuilder(objectIdentifier: databasePart.authorID)
        activeBuilders["AuthorBuilder"] = builder
        builder.build {
            completionHandler()
        }
        self.author = builder.getResult()
    }
    
    func getResult() -> MatchResult {
        return proxy
    }
    
}
