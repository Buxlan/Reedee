//
//  MKMapViewExtension.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 10/31/21.
//

import MapKit

extension MKMapView {
    
    func centerToCoordinate(_ coordinate: CLLocationCoordinate2D,
                            regionRadius: CLLocationDistance = 8000) {
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        self.setRegion(coordinateRegion, animated: true)
    }
    
}
