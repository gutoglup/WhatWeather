//
//  AddressLocation.swift
//  WhatWeather
//
//  Created by Augusto Reis on 09/08/22.
//

import Foundation
import CoreLocation

struct AddressLocation: Identifiable, Decodable {
    
    var id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    let state: String?
    let country: String
    
    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "lon"
        case state
        case country
    }
}
