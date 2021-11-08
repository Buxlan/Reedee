//
//  MatchResultDetailViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/4/21.
//

import Firebase
import FirebaseDatabaseUI

class MatchResultDetailViewModel: NSObject {
    
    // MARK: - Properties
    
    typealias InputDataType = MatchResult
    var inputData: InputDataType?
    var dataSource: [OldTableRow<InputDataType>] = []
    
    // MARK: Lifecircle    
        
    // MARK: - Hepler functions
}

extension MatchResultDetailViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
}
