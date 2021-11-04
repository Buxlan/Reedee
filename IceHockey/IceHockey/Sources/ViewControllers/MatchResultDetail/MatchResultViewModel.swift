//
//  MatchResultViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/4/21.
//

import Firebase
import FirebaseDatabaseUI

class MatchResultViewModel: NSObject {
    
    // MARK: - Properties
    
    typealias InputDataType = MatchResult
    var inputData: InputDataType?
    var dataSource: [TableRow<InputDataType>] = []
    
    // MARK: Lifecircle
    
        
    // MARK: - Hepler functions
}

extension MatchResultViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
}
