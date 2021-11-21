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
    var trainings: [Workout]
    
    var textColor: UIColor = Asset.textColor.color
    var backgroundColor: UIColor = Asset.other3.color
    var font: UIFont = .regularFont17
        
    // MARK: - Actions
    
    // MARK: - Lifecircle
    
    init(data: DayWorkout) {
        self.day = data.day.description
        self.trainings = data.time
    }
    
}
