//
//  HomeViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import Firebase
import FirebaseDatabaseUI

class HomeViewModel: NSObject {
    
    // MARK: - Properties
    struct SectionData {
        var title: String = ""
        var events: [SportEvent] = []
    }
    var sections: [SectionData] = []    
    
    var dataSource: [TableRow] = []
    var items: [IndexPath: TableRow] = [:]
    
    var shouldRefreshRelay = {}
    var shouldRefreshAtIndexPathRelay: (IndexPath) -> Void = { _ in }
    
    var databaseQuery: DatabaseQuery {
        FirebaseManager.shared.databaseManager.root.child("events")
            .queryOrdered(byChild: "order")
            .queryLimited(toFirst: 10)
    }
    
    private lazy var actions: [ActionCollectionCellConfigurator] = {
        [
            ActionCollectionCellConfigurator(data: QuickAction.joinClub),
            ActionCollectionCellConfigurator(data: QuickAction.contacts),
            ActionCollectionCellConfigurator(data: QuickAction.showTrainingSchedule),
            ActionCollectionCellConfigurator(data: QuickAction.showOnMap)
        ]
    }()
    
    var actionsCount: Int {
        actions.count
    }
    
    // MARK: Lifecircle
            
    // MARK: - Hepler functions     
    
    func action(at indexPath: IndexPath) -> ActionCollectionCellConfigurator {
        actions[indexPath.item]
    }
    
    func update() {
        var section = SectionData()
        databaseQuery.getData { error, snapshot in
            if let error = error {
                preconditionFailure()
            }
            
            for child in snapshot.children {
                guard let child = child as? DataSnapshot else {
                    continue
                }
                let completionHandler: (SportEvent?) -> Void = { event in
                    guard let event = event else {
                        return
                    }
                    if let index = section.events.firstIndex(where: { $0.uid == event.uid }) {
                        section.events[index] = event
                        self.sections = [section]
                        self.shouldRefreshRelay()
                    }
                }
                let creator = SportEventCreatorImpl()
                let event = creator.create(snapshot: child, with: completionHandler)
                if let event = event {
                    section.events.append(event)
                }
            }
            self.sections.append(section)
            self.shouldRefreshRelay()
        }
    }
    
}

extension HomeViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = self.items[indexPath]
        row?.action()
    }
    
}
