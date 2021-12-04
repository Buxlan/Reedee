//
//  Coord.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/22/21.
//

struct Coord: Codable {
        
    var longitude: Double
    var latitude: Double
    
    init() {
        self.latitude = 0.0
        self.longitude = 0.0
    }
    
    init(longitude: Double, latitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init?(dictionary: [String: Double]) {
        guard let longitude = dictionary["longitude"],
           let latitude = dictionary["latitude"] else {
            return nil
        }
        self.longitude = longitude
        self.latitude = latitude
    }
    
}
