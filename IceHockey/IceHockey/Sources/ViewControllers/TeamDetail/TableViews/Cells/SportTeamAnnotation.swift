//
//  SportTeamAnnotation.swift
//  IceHockey
//
//  Created by  Buxlan on 10/31/21.
//

import MapKit

class SportTeamAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        super.init()
    }        
}
