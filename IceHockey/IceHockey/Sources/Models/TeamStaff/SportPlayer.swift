//
//  HockeyPlayer.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//
import Firebase

struct SportPlayer: FirebaseObject, Codable {
    
    var uid: String
    var displayName: String
    var smallImage: String = ""
    var largeImage: String = ""
    var position: HockeyPlayerRole
    var number: String
    
    // MARK: - Lifecircle
    
    init?(snapshot: DataSnapshot) {
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        self.init(key: uid, dict: dict as NSDictionary)
    }
    
    init?(key: String, dict: NSDictionary) {
        guard let displayName = dict["displayName"] as? String else { return nil }
        guard let number = dict["number"] as? String else { return nil }
        let type = (dict["type"] as? Int) ?? 0
        let position = HockeyPlayerRole(rawValue: type)
                
        self.uid = key
        self.displayName = displayName
        self.number = number
        self.position = position
    }
    
    // MARK: - Helper methods
    
    func delete() {
        do {
            try FirebaseManager.shared.delete(self)
        } catch AppError.dataMismatch {
            print("Data mismatch")
        } catch {
            print("Some other error")
        }
    }
    
}
