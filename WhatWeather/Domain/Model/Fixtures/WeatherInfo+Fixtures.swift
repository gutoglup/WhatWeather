//
//  WeatherInfo+Fixtures.swift
//  WhatWeather
//
//  Created by Augusto Reis on 10/08/22.
//

import Foundation

extension WeatherInfo {
    
    static func fixture(
        id: Int = 0,
        main: String = "Coulds",
        description: String = "few clouds",
        icon: String = "02d"
    ) -> WeatherInfo {
        WeatherInfo(
            id: id,
            main: main,
            description: description,
            icon: icon)
    }
}
