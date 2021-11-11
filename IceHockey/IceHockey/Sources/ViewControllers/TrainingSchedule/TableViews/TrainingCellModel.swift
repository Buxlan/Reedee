//
//  TrainingCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/10/21.
//

import UIKit

struct TrainingCellModel: TableCellModel {
    
    // MARK: - Properties
    var day: String
    var trainings: [TrainingTime]
        
    // MARK: - Actions
    
    // MARK: - Lifecircle
    
    init(data: DailyTraining) {
        self.day = data.day.description
        self.trainings = data.time
    }
    
}
