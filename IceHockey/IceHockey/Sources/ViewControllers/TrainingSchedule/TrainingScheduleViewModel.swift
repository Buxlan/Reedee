//
//  OurSquadsViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/01/21.
//

import Firebase

class TrainingScheduleViewModel {
    
    // MARK: - Properties
    struct SectionData {
        let squad: Squad
        let schedule: WorkoutSchedule
    }
        
    var team: Club = ClubManager.shared.current
    var sections: [SectionData] = []
    var isLoading: Bool {
        return loader.isLoading
    }
    private var loader = WorkoutScheduleListLoader()
    private var activeCreators: [SquadCreator] = []
    
    
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
    
    func update() {
        
        let completionHandler: ([WorkoutSchedule]) -> Void = { [weak self] schedules in
            guard schedules.count > 0 else {
                return
            }
            self?.activeCreators.removeAll()
            self?.sections.removeAll()
            for schedule in schedules {
                let creator = SquadCreator()
                self?.activeCreators.append(creator)
                let squad = creator.create(
                    objectIdentifier: schedule.objectIdentifier) {
                        guard let self = self else { return }
                        if let index = self.activeCreators.firstIndex(
                            where: { $0 === creator }) {
                            self.activeCreators.remove(at: index)
                        }                        
                        self.shouldRefreshRelay()
                    }
                let section = SectionData(squad: squad, schedule: schedule)
                self?.sections.append(section)
            }
            self?.shouldRefreshRelay()
            
        }
        loader.load(completionHandler: completionHandler)

    }
    
}
