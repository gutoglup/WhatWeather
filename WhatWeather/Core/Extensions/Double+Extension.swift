//
//  Double+Extension.swift
//  WhatWeather
//
//  Created by Augusto Reis on 07/07/22.
//

import Foundation

extension Double {
    
    var temperatureLocalized: String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        let measurement = Measurement(value: self, unit: UnitTemperature.kelvin)
        return measurementFormatter.string(from: measurement)
    }
}
