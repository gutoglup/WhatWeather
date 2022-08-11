//
//  WeatherIconRepository.swift
//  WhatWeather
//
//  Created by Augusto Reis on 11/08/22.
//

import Combine
import Foundation

protocol WeatherIconRepository {
    func getIcon(params: WeatherIconParams) -> AnyPublisher<URL, Error>
}
