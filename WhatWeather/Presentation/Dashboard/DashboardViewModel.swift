//
//  DashboardViewModel.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import Combine
import CoreLocation

final class DashboardViewModel: ObservableObject {
    
    @Published var result: WeatherData?
    var cancellable: Cancellable?
    
    private let getCurrentWeatherUseCase: GetCurrentWeatherUseCase
    
    init(getCurrentWeatherUseCase: GetCurrentWeatherUseCase) {
        self.getCurrentWeatherUseCase = getCurrentWeatherUseCase
    }
    
    func getCurrentWeather() {
        cancellable = getCurrentWeatherUseCase.getCurrentWeather(params: OneCallRequestParams(location: CLLocationCoordinate2D(latitude: -47.97, longitude: -15.87)))
            .map { weatherData -> WeatherData in
            print(weatherData)
            return weatherData
            }.sink(receiveCompletion: {
                print($0)
            }, receiveValue: { weatherData in
                self.result = weatherData
            })
        
    }
}
