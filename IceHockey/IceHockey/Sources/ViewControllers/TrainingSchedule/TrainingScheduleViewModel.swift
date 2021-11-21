//
//  OurSquadsViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/01/21.
//

import Firebase

class TrainingScheduleViewModel: NSObject {
    
    // MARK: - Properties
    struct SectionData {
        let squad: SportSquad
        let schedule: WorkoutSchedule
    }
        
    var team: SportTeam = SportTeam.current
    var sections: [SectionData] = []
    var isLoading: Bool {
        return loader.isLoading
    }
    private var loader = WorkoutScheduleListLoader()
    
    var shouldRefreshRelay = {}
    
    var objectsDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("squads")
    }
    
    // MARK: Lifecircle
        
    // MARK: - Hepler functions
    
    func getSectionTitle(at index: Int) -> String {
        sections[index].squad.displayName
    }
    
    func item(at indexPath: IndexPath) -> DayWorkout {
        sections[indexPath.section].schedule.workouts[indexPath.row]
    }
    
    private func loadItems() {
        
//        guard let team = team else {
//            return
//        }
//        sections.removeAll()
//        team.squadIDs.forEach { squadID in
//            let handler: (SportSquad?) -> Void = { squad in
//                guard let squad = squad else {
//                    let index = self.loadings.firstIndex { $0 == squadID }
//                    if let index = index {
//                        self.loadings.remove(at: index)
//                    }
//                    return
//                }
//                let handler: (TrainingSchedule?) -> Void = { schedule in
//                    defer {
//                        let index = self.loadings.firstIndex { $0 == squadID }
//                        if let index = index {
//                            self.loadings.remove(at: index)
//                        }
//                        if self.loadings.isEmpty {
//                            self.shouldRefreshRelay()
//                        }
//                    }
//                    guard let schedule = schedule else {
//                        return
//                    }
//                    let section = SectionData(squad: squad, schedule: schedule)
//                    self.sections.append(section)
//                }
//                FirebaseObjectLoader<TrainingSchedule>().load(uid: squadID, completionHandler: handler)
//            }
//            loadings.append(squadID)
//            FirebaseObjectLoader<SportSquad>().load(uid: squadID, completionHandler: handler)
//        }
    
    }
    
    func update() {
        
        let completionHandler: ([WorkoutSchedule]) -> Void = { schedules in
            guard schedules.count > 0 else {
                return
            }
            self.sections.removeAll()
            schedules.forEach { schedule in
                guard let squad = self.getSquad(by: schedule.uid) else {
                    return
                }
                let section = SectionData(squad: squad, schedule: schedule)
                self.sections.append(section)
            }
            self.shouldRefreshRelay()
            
        }
        loader.load(completionHandler: completionHandler)
        
//        guard loadings.count == 0,
//            let teamID = Bundle.main.object(forInfoDictionaryKey: "teamID") as? String else {
//            return
//        }
//        let handler: (SportTeam?) -> Void = { (team) in
//            if let team = team {
//                self.team = team
//                self.loadings.removeAll()
//                self.loadItems()
//            }
//        }
//        loadings.append(teamID)
//        FirebaseObjectLoader<SportTeam>().load(uid: teamID, completionHandler: handler)
    }
    
    private func getSquad(by uid: String) -> SportSquad? {
        guard let index = team.squadIDs.firstIndex(where: { $0 == uid }) else {
            return nil
        }
        let squad = SportSquad(uid: uid, displayName: "12313", headCoach: "4341")
        return squad
    }
    
}
