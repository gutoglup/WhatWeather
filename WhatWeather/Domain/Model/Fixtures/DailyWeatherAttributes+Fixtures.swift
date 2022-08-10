//
//  DailyWeatherAttributes+Fixtures.swift
//  WhatWeather
//
//  Created by Augusto Reis on 10/08/22.
//

import Foundation

extension DailyWeatherAttributes {
    
    static func fixture(
        currentTime: Int = Int(Date().timeIntervalSince1970),
        sunrise: Int? = Int(Date().timeIntervalSince1970),
        sunset: Int? = Int(Date().timeIntervalSince1970),
        moonrise: Int? = Int(Date().timeIntervalSince1970),
        moonset: Int? = Int(Date().timeIntervalSince1970),
        moonphase: Double? = 0,
        temperature: DailyTemperature? = .fixture(),
        feelsLike: DailyTemperature = .fixture(),
        pressure: Int = 0,
        humidity: Int = 0,
        dewPoint: Double = 0,
        windSpeed: Double = 0,
        windDeg: Int = 0,
        weather: [WeatherInfo] = [.fixture()],
        clouds: Int = 0,
        pop: Double = 0,
        rain: Double? = 0,
        uvi: Double = 0
    ) -> DailyWeatherAttributes {
        DailyWeatherAttributes(
            currentTime: currentTime,
            sunrise: sunrise,
            sunset: sunset,
            moonrise: moonrise,
            moonset: moonset,
            moonphase: moonphase,
            temperature: temperature,
            feelsLike: feelsLike,
            pressure: pressure,
            humidity: humidity,
            dewPoint: dewPoint,
            windSpeed: windSpeed,
            windDeg: windDeg,
            weather: weather,
            clouds: clouds,
            pop: pop,
            rain: rain,
            uvi: uvi)
    }
}
