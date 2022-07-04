//
//  GetCurrentWeatherUseCase.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import Combine

protocol GetCurrentWeatherUseCase {
    
}

struct GetCurrentWeatherUseCaseImpl: GetCurrentWeatherUseCase {
    
    private let repository: OneCallRepository
    
    func getCurrentWeatherUseCase(params: OneCallRequestParams) -> AnyPublisher<WeatherData, Error> {
        repository.getCurrentWeather(params: params)
    }
}
