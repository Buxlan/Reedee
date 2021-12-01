//
//  TeamListViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/28/21.
//

//import Firebase
//
//class TeamListViewModel {
//    
//    // MARK: - Properties
//    typealias DataType = SportTeam
//    
//    weak var delegate: CellUpdatable? {
//        didSet {
//            dataSource = FUITableViewDataSource(query: databaseQuery, populateCell: populateCell)
//        }
//    }
//    var dataSource: FUITableViewDataSource?
//    
//    private lazy var populateCell: ((UITableView, IndexPath, DataSnapshot) -> UITableViewCell) = { (_, indexPath, snap) -> UITableViewCell in
//        guard let data = DataType(snapshot: snap),
//              let delegate = self.delegate else {
//            return UITableViewCell()
//        }
//        let configurator = TeamCellConfigurator(data: data)
//        return delegate.configureCell(at: indexPath, configurator: configurator)
//    }
//    
//    private var storageReference: StorageReference = {
//        FirebaseManager.shared.storageManager.root.child("teams")
//    }()
//    var databaseQuery: DatabaseQuery {
//        FirebaseManager.shared.databaseManager.root.child("teams")
//    }    
//    
//    // MARK: Lifecircle
//            
//    // MARK: - Hepler functions
//    
//    func item(at indexPath: IndexPath) -> DataType {
//        guard let snapshot = dataSource?.items[indexPath.row],
//              let data = DataType(snapshot: snapshot) else {
//            fatalError("Cant get item at index \(indexPath.row)")
//        }
//        return data
//    }
//    
//    func deleteItem(at indexPath: IndexPath) {
//        let item = self.item(at: indexPath)
//        try? item.delete()
//    }
//    
//}
