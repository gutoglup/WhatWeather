//
//  GetWeatherIconUseCase.swift
//  WhatWeather
//
//  Created by Augusto Reis on 11/08/22.
//

import Foundation
import Combine

protocol GetWeatherIconUseCase {
    func getIcon(name: String) -> AnyPublisher<URL, Error>
}

struct GetWeatherIconUseCaseImpl: GetWeatherIconUseCase {
    
    private let repository: WeatherIconRepository
    
    init(repository: WeatherIconRepository) {
        self.repository = repository
    }
    
    func getIcon(name: String) -> AnyPublisher<URL, Error> {
        let params = WeatherIconParams(name: name)
        return repository.getIcon(params: params)
    }
}
