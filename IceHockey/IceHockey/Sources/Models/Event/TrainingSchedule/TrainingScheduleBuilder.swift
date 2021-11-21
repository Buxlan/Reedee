//
//  TrainingScheduleBuilder.swift
//  IceHockey
//
//  Created by  Buxlan on 11/21/21.
//

class TrainingScheduleBuilder {
    
    // MARK: - Properties
    
    private let key: String
    private let dict: [String: Any]
    
    private var databasePart: TrainingScheduleDatabaseFlowData
    
    private var completionHandler: (TrainingSchedule?) -> Void = { _ in }
    
    // MARK: - Lifecircle
    
    init(key: String, dict: [String: Any]) {
        self.key = key
        self.dict = dict
        databasePart = DefaultTrainingScheduleDatabaseFlowData()
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping (SportEvent?) -> Void) {
        self.completionHandler = completionHandler
        buildDatabasePart()
    }
    
    private func buildDatabasePart() {
        self.databasePart = TrainingScheduleDatabaseFlowDataImpl(key: key, dict: dict)
        completionHandler()
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

