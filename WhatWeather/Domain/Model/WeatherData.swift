//
//  Weather.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import CoreLocation

struct WeatherData: Decodable {
    
    let latitude: Double
    let longitude: Double
    
    let timezone: String
    let timezoneOffset: Int
    let current: WeatherAttributes
    let hourly: [WeatherAttributes]
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        
        case timezone
        case timezoneOffset = "timezone_offset"
        case current
        case hourly
    }
}
