//
//  GetCurrentWeatherUseCase.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import Combine

protocol GetCurrentWeatherUseCase {
    func getCurrentWeather(params: OneCallRequestParams) -> AnyPublisher<WeatherData, Error>
}

struct GetCurrentWeatherUseCaseImpl: GetCurrentWeatherUseCase {
    
    private let repository: OneCallRepository
    
    init(repository: OneCallRepository) {
        self.repository = repository
    }
    
    func getCurrentWeather(params: OneCallRequestParams) -> AnyPublisher<WeatherData, Error> {
        repository.getCurrentWeather(params: params)
    }
}
