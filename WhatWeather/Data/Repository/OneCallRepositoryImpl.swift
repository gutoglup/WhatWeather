//
//  OneCallRepositoryImpl.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import Foundation
import Combine

struct OneCallRepositoryImpl: OneCallRepository {
    
    private let dataSource: OneCallDataSource
    
    init(dataSource: OneCallDataSource) {
        self.dataSource = dataSource
    }
    
    func getCurrentWeather(params: OneCallRequestParams) -> AnyPublisher<WeatherData, Error> {
        dataSource.getCurrentWeather(params: params)
            .eraseToAnyPublisher()
    }
}
