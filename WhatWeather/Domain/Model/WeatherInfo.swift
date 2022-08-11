//
//  WeatherInfo.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import Foundation

struct WeatherInfo: Decodable {
    
    let id: Int
    let main: String
    let description: String
    let icon: String
    var iconUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }
}
