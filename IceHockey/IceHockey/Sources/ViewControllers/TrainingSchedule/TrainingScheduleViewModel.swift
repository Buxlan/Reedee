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
        
    var club: Club?
    var sections: [SectionData] = []
    var isLoading: Bool {
        return loader.isLoading
    }
    private var loader = WorkoutScheduleListLoader()
    private var activeCreators: [String: SquadCreator] = [:]
       
    var shouldRefreshRelay: () -> Void = {} {
        didSet {
            club = ClubManager.shared.current
            ClubManager.shared.addObserver(self)
            update()
        }
    }
    
    var objectsDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("squads")
    }
    
    // MARK: Lifecircle
    
    deinit {
        ClubManager.shared.removeObserver(self)
    }
        
    // MARK: - Hepler functions
    
    func sectionTitle(at index: Int) -> String {
        sections[index].squad.displayName
    }
    
    func item(at indexPath: IndexPath) -> DayWorkout {
        sections[indexPath.section].schedule.workouts[indexPath.row]
    }
    
    func update() {
        
        guard let club = club else {
            return
        }
                
        let completionHandler: ([WorkoutSchedule]) -> Void = { [weak self] schedules in
            guard schedules.count > 0 else {
                return
            }
            self?.activeCreators.removeAll()
            self?.sections.removeAll()
            for schedule in schedules {
                let creator = SquadCreator()
                self?.activeCreators[schedule.objectIdentifier] = creator
                let squad = creator.create(objectIdentifier: schedule.objectIdentifier) {
                        self?.activeCreators[schedule.objectIdentifier] = nil
                        self?.shouldRefreshRelay()
                    }
                let section = SectionData(squad: squad, schedule: schedule)
                self?.sections.append(section)
            }
            self?.shouldRefreshRelay()
        }
        loader.load(completionHandler: completionHandler)

    }
    
}

extension TrainingScheduleViewModel: ClubObserver {
    
    func didChangeTeam(_ club: Club) {
        self.club = club
        update()
    }
    
}
