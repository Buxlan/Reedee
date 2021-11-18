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
    private var loadingHandlers: [Int: (SportEvent?) -> Void] = [:]
    
    var isLoading: Bool {
        return !loadingHandlers.isEmpty
    }
    
    var shouldRefreshRelay = {}
    var shouldRefreshAtIndexPathRelay: (IndexPath) -> Void = { _ in }
    
    var databaseQuery: DatabaseQuery {
        FirebaseManager.shared.databaseManager.root.child("events")
            .queryOrdered(byChild: "order")
            .queryLimited(toFirst: 2)
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
            assert(error == nil)
            self.loadingHandlers.removeAll()
            for (index, _) in snapshot.children.enumerated() {
                let completionHandler: (SportEvent?) -> Void = { event in
                    guard let event = event else {
                        return
                    }
                    if let index = self.loadingHandlers.firstIndex(where: { (key, _) in
                        key == index
                    }) {
                        self.loadingHandlers.remove(at: index)
                    }
                    if let index = section.events.firstIndex(where: { $0.uid == event.uid }) {
                        section.events[index] = event
                        self.sections = [section]
                        self.shouldRefreshRelay()
                    }
                }
                self.loadingHandlers[index] = completionHandler
            }
            for (index, child) in snapshot.children.enumerated() {
                guard let child = child as? DataSnapshot,
                      let handler = self.loadingHandlers[index] else {
                    continue
                }
                let creator = SportEventCreatorImpl()
                let event = creator.create(snapshot: child, with: handler)
                if let event = event {
                    section.events.append(event)
                }
            }
            self.sections.append(section)
            self.shouldRefreshRelay()
        }
    }
    
}
