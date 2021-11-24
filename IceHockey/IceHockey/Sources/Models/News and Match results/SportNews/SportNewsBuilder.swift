//
//  SportNewsBuilder.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/18/21.
//

class SportNewsBuilder {
    
    // MARK: - Properties
    
    private let objectIdentifier: String
    var dict: [String: Any]?
    
    private var databasePart: SportNewsDatabaseFlowData = EmptySportNewsDatabaseFlowData()
    private var storagePart: StorageFlowData = EmptyStorageFlowData()
    private var author: SportUser?
    private var likesInfo: EventLikesInfo = EventLikesInfoImpl.empty
    private var viewsInfo: EventViewsInfo = EventViewsInfoImpl.empty
    
    private var completionHandler: (SportEvent?) -> Void = { _ in }
    private var proxy = SportNewsProxy()
    
    // MARK: - Lifecircle
    
    init(objectIdentifier: String) {
        self.objectIdentifier = objectIdentifier
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping () -> Void) {
        guard !objectIdentifier.isEmpty else {
            completionHandler()
            return
        }
        proxy.loadingCompletionHandler = completionHandler
        buildDatabasePart {
            self.buildAuthor {
                self.buildLikesInfo {
                    self.buildStoragePart {
                        let object = SportNewsImpl(databaseFlowObject: self.databasePart,
                                                   storageFlowObject: self.storagePart,
                                                   author: self.author,
                                                   likesInfo: self.likesInfo,
                                                   viewsInfo: self.viewsInfo)
                        self.proxy.event = object
                    }
                }
            }
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        if let dict = dict {
            self.databasePart = SportNewsDatabaseFlowDataImpl(key: objectIdentifier, dict: dict)
        }
        completionHandler()
    }
    
    private func buildStoragePart(completionHandler: @escaping () -> Void) {
        guard !databasePart.objectIdentifier.isEmpty else {
                  completionHandler()
                  return
              }
        let loader = EventImagesLoader(objectIdentifier: databasePart.objectIdentifier,
                                        imagesIdentifiers: databasePart.imageIDs)
        loader.load { data in
            if let data = data {
                self.storagePart = data
            }
            completionHandler()
        }
    }
    
    private func buildLikesInfo(completionHandler: @escaping () -> Void) {
        let builder = EventLikeInfoBuilder(key: objectIdentifier)
        builder.build { likesInfo in
            if let likesInfo = likesInfo {
                self.likesInfo = likesInfo
            }
            completionHandler()
        }
    }
    
    private func buildAuthor(completionHandler: @escaping () -> Void) {
        let builder = SportUserBuilder(key: databasePart.authorID)
        builder.build {
            completionHandler()
        }
        self.author = builder.getResult()
    }
    
    func getResult() -> SportNews {
        return proxy
    }
    
}
