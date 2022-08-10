//
//  DailyTemperature+Fixtures.swift
//  WhatWeather
//
//  Created by Augusto Reis on 10/08/22.
//

import Foundation

extension DailyTemperature {
    
    static func fixture(
        day: Double = 260,
        min: Double? =  220,
        max: Double? =  280,
        night: Double =  260,
        eve: Double =  260,
        morn: Double =  260
    ) -> DailyTemperature {
        DailyTemperature(
            day: day,
            min: min,
            max: max,
            night: night,
            eve: eve,
            morn: morn)
    }
}
