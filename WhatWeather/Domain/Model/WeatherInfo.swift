//
//  WeatherInfo.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

struct WeatherInfo: Decodable {
    
    let id: Int
    let main: String
    let description: String
    let icon: String
}
