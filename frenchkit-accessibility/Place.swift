//
//  Place.swift
//  frenchkit-accessibility
//
//  Created by amath on 15/09/16.
//  Copyright © 2016 amath. All rights reserved.
//

import Foundation
import MapKit

class Place: NSObject, MKAnnotation{
    
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    let imageName: String?
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D, imageName: String) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.imageName = imageName
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
}
