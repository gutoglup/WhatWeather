//
//  OneCallDataSource.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import Combine

protocol OneCallDataSource {
    
    func getCurrentWeather(params: OneCallRequestParams) -> AnyPublisher<WeatherData, Error>
}
