//
//  WeatherData+Fixtures.swift
//  WhatWeather
//
//  Created by Augusto Reis on 18/08/22.
//

import Foundation

extension WeatherData {
    
    static func fixture() -> WeatherData {
        WeatherData(
            latitude: 10.4,
            longitude: 11.2,
            timezone: "BR",
            timezoneOffset: -3,
            current: .fixture(),
            hourly: [.fixture()],
            daily: [.fixture()])
    }
}
