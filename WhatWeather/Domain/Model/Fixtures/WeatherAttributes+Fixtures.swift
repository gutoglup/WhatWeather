//
//  WeatherAttributes+Fixtures.swift
//  WhatWeather
//
//  Created by Augusto Reis on 10/08/22.
//

import Foundation

extension WeatherAttributes {
    
    static func fixture(
        currentTime: Int = Int(Date().timeIntervalSince1970),
        sunrise: Int = Int(Date().timeIntervalSince1970),
        sunset: Int = Int(Date().timeIntervalSince1970),
        temperature: Double = 50,
        feelsLike: Double = 50,
        pressure: Int = 0,
        humidity: Int = 100,
        dewPoint: Double = 0,
        uvi: Double = 0,
        clouds: Int = 0,
        visibility: Int = 0,
        windSpeed: Double = 0,
        windDeg: Int = 0,
        windGust: Double = 0,
        weather: [WeatherInfo] = [.fixture()]
    ) -> WeatherAttributes {
        WeatherAttributes(
            currentTime: currentTime,
            sunrise: sunrise,
            sunset: sunset,
            temperature: temperature,
            feelsLike: feelsLike,
            pressure: pressure,
            humidity: humidity,
            dewPoint: dewPoint,
            uvi: uvi,
            clouds: clouds,
            visibility: visibility,
            windSpeed: windSpeed,
            windDeg: windDeg,
            windGust: windGust,
            weather: weather)
    }
}
