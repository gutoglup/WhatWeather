//
//  PlaceDetailViewModel.swift
//  WhatWeather
//
//  Created by Augusto Reis on 18/08/22.
//

import Foundation
import Combine
import CoreLocation

final class PlaceDetailViewModel: ObservableObject {
    
    @Published var state: LoadingState<WeatherData> = .idle
    private var cancellabels: Set<AnyCancellable> = []
    
    private let location: CLLocationCoordinate2D
    private var weatherData: WeatherData?
    private let getCurrentWeatherUseCase: GetCurrentWeatherUseCase
    
    init(getCurrentWeatherUseCase: GetCurrentWeatherUseCase,
         location: CLLocationCoordinate2D) {
        self.getCurrentWeatherUseCase = getCurrentWeatherUseCase
        self.location = location
    }
    
    func getCurrentWeather() {
        state = .loading
        let params = OneCallRequestParams(location: location)
            getCurrentWeatherUseCase.getCurrentWeather(params: params)
            .retry(2)
            .sink { completion in
                print(completion)
            } receiveValue: { weatherData in
                self.state = .loaded(weatherData)
                self.weatherData = weatherData
            }
            .store(in: &cancellabels)
    }
    
    func getWeatherHourly() -> [WeatherAttributes] {
        Array<WeatherAttributes>(weatherData?.hourly.prefix(24) ?? [])
    }
    
    func getWeatherDaily() -> [DailyWeatherAttributes] {
        Array(weatherData?.daily.prefix(10) ?? [])
    }
}
