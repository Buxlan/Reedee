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
    var dataSource = TableDataSource()
    var shouldRefreshRelay = {}
    var shouldRefreshAtIndexPathRelay: (IndexPath) -> Void = { _ in }
    var isLoading: Bool {
        return loader.isLoading
    }
    private var loader = SportEventListLoader()
    
    // MARK: - Actions
    
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
        loader.flush()
        let eventListCompletionHandler: ([SportEvent]) -> Void = { events in
            guard events.count > 0 else {
                return
            }
            var section = SectionData()
            section.events.append(contentsOf: events)
            self.sections = [section]
            self.shouldRefreshRelay()
        }
        let eventLoadedCompletionHandler: (SportEvent) -> Void = { event in
            assert(self.sections.count > 0)
            if let index = self.sections[0].events.firstIndex(where: { $0.uid == event.uid }) {
                self.sections[0].events[index] = event
                self.shouldRefreshRelay()
            }
        }
        loader.load(eventListCompletionHandler: eventListCompletionHandler,
                    eventLoadedCompletionHandler: eventLoadedCompletionHandler)
    }
    
    func nextUpdate() {
        let eventListCompletionHandler: ([SportEvent]) -> Void = { events in
            assert(self.sections.count > 0)
            guard events.count > 0 else {
                return
            }
            events.forEach { event in
                if let index = self.sections[0].events.firstIndex(where: { $0.uid == event.uid }) {
                    self.sections[0].events[index] = event
                } else {
                    self.sections[0].events.append(event)
                }
            }
            self.shouldRefreshRelay()
        }
        let eventLoadedCompletionHandler: (SportEvent) -> Void = { event in
            assert(self.sections.count > 0)
            if let index = self.sections[0].events.firstIndex(where: { $0.uid == event.uid }) {
                self.sections[0].events[index] = event
                self.shouldRefreshRelay()
            }
        }
        loader.load(eventListCompletionHandler: eventListCompletionHandler,
                    eventLoadedCompletionHandler: eventLoadedCompletionHandler)
    }
    
}
