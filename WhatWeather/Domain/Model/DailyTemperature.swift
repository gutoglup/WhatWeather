//
//  DailyTemperature.swift
//  WhatWeather
//
//  Created by Augusto Reis on 07/07/22.
//

import Foundation

struct DailyTemperature: Decodable {
    
    let day: Double
    let min: Double?
    let max: Double?
    let night: Double
    let eve: Double
    let morn: Double
}
