//
//  SportNewsBuilder.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/18/21.
//

class SportNewsBuilder {
    
    // MARK: - Properties
    
    private let key: String
    private let dict: [String: Any]
    
    private var databasePart: SportNewsDatabaseFlowData
    private var storagePart: SportNewsStorageFlowData
    private var author: SportUser
    private var likesInfo = EventLikesInfo()
    private var viewsInfo = EventViewsInfo()
    
    private var completionHandler: (SportEvent?) -> Void = { _ in }
    
    // MARK: - Lifecircle
    
    init(key: String, dict: [String: Any]) {
        self.key = key
        self.dict = dict
        databasePart = DefaultSportNewsDatabaseFlowData()
        storagePart = DefaultSportNewsStorageFlowData()
        author = SportUser()
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping (SportEvent?) -> Void) {
        self.completionHandler = completionHandler
        buildDatabasePart {
            self.buildAuthor() {
                self.buildLikesInfo() {
                    self.buildStoragePart()
                }
            }
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        self.databasePart = SportNewsDatabaseFlowDataImpl(key: key, dict: dict)
        completionHandler()
    }
    
    private func buildStoragePart() {
        guard !databasePart.uid.isEmpty else {
                  self.completionHandler(nil)
                  return
              }
        storagePart = SportNewsStorageFlowDataImpl(eventID: databasePart.uid,
                                                   imageIDs: databasePart.imageIDs)
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
    
    func getResult() -> SportNews? {
        let object = SportNews(databaseFlowObject: databasePart,
                               storageFlowObject: storagePart,
                               author: author,
                               likesInfo: likesInfo,
                               viewsInfo: viewsInfo)
        return object
    }
    
}
