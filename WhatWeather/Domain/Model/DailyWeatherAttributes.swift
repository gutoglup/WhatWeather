//
//  DailyWeatherAttributes.swift
//  WhatWeather
//
//  Created by Augusto Reis on 07/07/22.
//

import Foundation

struct DailyWeatherAttributes: Decodable, Identifiable {
    
    var id = UUID()
    let currentTime: Int
    let sunrise: Int?
    let sunset: Int?
    let moonrise: Int?
    let moonset: Int?
    let moonphase: Double?
    let temperature: DailyTemperature?
    let feelsLike: DailyTemperature
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let windSpeed: Double
    let windDeg: Int
    let weather: [WeatherInfo]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double
    
    var dateFormatted: String {
        currentTime.toDateExtensiveFormatted
    }
    
    enum CodingKeys: String, CodingKey {
        case currentTime = "dt"
        case sunrise
        case sunset
        case moonrise
        case moonset
        case moonphase
        case temperature = "temp"
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather
        case clouds
        case pop
        case rain
        case uvi
    }
}
