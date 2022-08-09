//
//  AddressLocation.swift
//  WhatWeather
//
//  Created by Augusto Reis on 09/08/22.
//

import Foundation

struct AddressLocation: Identifiable {
    
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
}
