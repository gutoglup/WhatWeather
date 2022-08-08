//
//  Int+Extension.swift
//  WhatWeather
//
//  Created by Augusto Reis on 08/08/22.
//

import Foundation

extension Int {
    
    var toDateFormatted: String {
        self.toFormat(.dayMonth)
    }
    
    var toHourFormatted: String {
        self.toFormat(.hourMinute)
    }
    
    var toDateExtensiveFormatted: String {
        self.toFormat(.dayExtensive).capitalized
    }
    
    func toFormat(_ format: DateFormats) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
}
