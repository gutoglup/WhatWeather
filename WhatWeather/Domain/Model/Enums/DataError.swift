//
//  DataError.swift
//  WhatWeather
//
//  Created by Augusto Reis on 03/08/22.
//

import Foundation

enum DataError: LocalizedError {
    case convertFailed
    case cannotUnwrapWeather
    
    var errorDescription: String? {
        "An internal error occurred"
    }
}
