//
//  WeatherAttributes.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import Foundation

struct WeatherAttributes: Decodable, Identifiable {
    
    var id = UUID()
    let currentTime: Int
    let sunrise: Int?
    let sunset: Int?
    let temperature: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double?
    var weather: [WeatherInfo]
    
    var temperatureFormatted: String {
        temperature.temperatureLocalized
    }
    
    var dateFormatted: String {
        currentTime.toDateFormatted
    }
    
    var hourFormatted: String {
        currentTime.toHourFormatted
    }
    
    enum CodingKeys: String, CodingKey {
        case currentTime = "dt"
        case sunrise
        case sunset
        case temperature = "temp"
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case uvi
        case clouds
        case visibility = "visibility"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather
    }
}
