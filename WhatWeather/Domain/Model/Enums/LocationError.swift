//
//  LocationError.swift
//  WhatWeather
//
//  Created by Augusto Reis on 05/07/22.
//

enum LocationError: Error {
    case unauthorized
    case unableToDetermineLocation
    case unableToSearchLocation
}
