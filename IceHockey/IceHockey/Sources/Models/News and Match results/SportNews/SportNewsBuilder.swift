//
//  SportNewsBuilder.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/18/21.
//

class SportNewsBuilder: FirebaseObjectBuilder {
    
    // MARK: - Properties
    
    private let objectIdentifier: String
    var dict: [String: Any]?
    
    private var databasePart: SportNewsDatabaseFlowData = EmptySportNewsDatabaseFlowData()
    private var storagePart: StorageFlowData = EmptyStorageFlowData()
    private var author: SportUser?
    private var likesInfo: EventLikesInfo = EventLikesInfoImpl.empty
    private var viewsInfo: EventViewsInfo = EventViewsInfoImpl.empty
    
    private var proxy = SportNewsProxy()
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
        log.debug("SportNewsBuilder build")
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
                        let object = SportNewsImpl(databaseFlowObject: self.databasePart,
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
        log.debug("SportNewsBuilder buildDatabasePart")
        if let dict = dict {
            self.databasePart = SportNewsDatabaseFlowDataImpl(key: objectIdentifier, dict: dict)
        }
        completionHandler()
    }
    
    private func buildStoragePart(completionHandler: @escaping () -> Void) {
        log.debug("SportNewsBuilder buildStoragePart")
        guard !databasePart.objectIdentifier.isEmpty else {
                  completionHandler()
                  return
              }
        let loader = EventImagesLoader(objectIdentifier: databasePart.objectIdentifier,
                                        imagesIdentifiers: databasePart.imageIDs)
        activeLoaders["EventImagesLoader"] = loader
        loader.load { [weak self] data in
            if let data = data {
                self?.storagePart = data
            }
            completionHandler()
        }
    }
    
    private func buildLikesInfo(completionHandler: @escaping () -> Void) {
        log.debug("SportNewsBuilder buildLikesInfo")
        let builder = EventLikeInfoBuilder(objectIdentifier: objectIdentifier)
        activeBuilders["LikesInfoBuilder"] = builder
        builder.build {
            completionHandler()
        }
        self.likesInfo = builder.getResult()
    }
    
    private func buildAuthor(completionHandler: @escaping () -> Void) {
        log.debug("SportNewsBuilder buildAuthor")
        let builder = SportUserBuilder(objectIdentifier: databasePart.authorID)
        activeBuilders["AuthorBuilder"] = builder
        builder.build {
            completionHandler()
        }
        self.author = builder.getResult()
    }
    
    func getResult() -> SportNews {
        return proxy
    }
    
}
