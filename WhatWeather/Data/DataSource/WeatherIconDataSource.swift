//
//  WeatherIconDataSource.swift
//  WhatWeather
//
//  Created by Augusto Reis on 11/08/22.
//

import Foundation
import Combine

protocol WeatherIconDataSource {
    
    func getIcon(params: WeatherIconParams) -> AnyPublisher<URL, Error>
}
