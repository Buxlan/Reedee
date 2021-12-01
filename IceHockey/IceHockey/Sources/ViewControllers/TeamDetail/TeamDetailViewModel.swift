//
//  TeamDetailViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/28/21.
//

import Firebase

struct OldTableSection<DataType> {
    var title: String
    var items: [DataType]
}

struct TeamDetailModel {
    
}

class TeamDetailViewModel: NSObject {
    
    // MARK: - Properties
    
    typealias DataType = Squad
    typealias PredicateType = Club
    typealias CellConfiguratorType = SquadCellConfigurator
    typealias TableRowType = OldTableRow<PredicateType>
    typealias TableSectionType = OldTableSection<TableRowType>
    
    var sections: [TableSectionType] = []
    
    let factory = FirebaseObjectFactory.shared
        
    var filter: PredicateType? {
        didSet {
            // get ids
            guard let filter = filter else {
                return
            }
            sections.removeAll()
            // prepare section 0
            let infoSectionItems: [CellConfigurator] = [
                TeamDetailInfoCellConfigurator(data: filter),
                MapCellConfigurator(data: filter)
            ]
            let rows = infoSectionItems.map { config in
                TableRowType(config: config, data: filter)
            }
            let infoSection = OldTableSection(title: L10n.Team.aboutClubTitle, items: rows)
            sections.append(infoSection)
            // prepare section 1
            let ids = filter.squadsIdentifiers
            // get objects
            objectsDatabaseReference.observe(.value) { snapshot in
                if snapshot.value == nil {
                    return
                }
                guard let result = snapshot.value as? [String: Any] else {
                    return
                }
                var items: [CellConfigurator] = []
                ids.forEach { [weak self] (uid) in
                    guard let self = self,
                        let item = result[uid] as? [String: Any] else {
                        return
                    }
                    let object = self.factory.makeSquad(with: uid) {
                        
                    }
                    let config = CellConfiguratorType(data: object)
                    items.append(config)
                }
                let rows = items.map { config in
                    TableRowType(config: config, data: filter)
                }
                let section = OldTableSection(title: L10n.Team.listTitle, items: rows)
                self.sections.append(section)
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
            }
            
        }
    }
    
    weak var delegate: CellUpdatable?
    
    // MARK: Lifecircle
    
    init(delegate: CellUpdatable) {
        super.init()
        self.delegate = delegate
    }
        
    // MARK: - Hepler functions
    
    var objectsDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("squads")
    }
    
    // MARK: Lifecircle
            
    // MARK: - Hepler functions
    
    func deleteItem(at indexPath: IndexPath) {
        if indexPath.section == 0 { return }
        let row = sections[indexPath.section].items[indexPath.row]
        do {
//            try row.data.delete()
        } catch AppError.dataMismatch {
            print("Data mismatch")
        } catch {
            print("Some other error")
        }
    }
    
    func row(at indexPath: IndexPath) -> TableRowType {
        return sections[indexPath.section].items[indexPath.row]
    }
    
    func config(at indexPath: IndexPath) -> CellConfigurator {
        return sections[indexPath.section].items[indexPath.row].config
    }
    
}

extension TeamDetailViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].items[indexPath.row]
        return delegate?.configureCell(at: indexPath, configurator: row.config) ?? UITableViewCell()
    }
    
}
