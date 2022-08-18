//
//  DashboardViewModel.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import Combine
import CoreLocation
import Foundation
import UIKit

final class DashboardViewModel: ObservableObject {
    
    @Published private(set) var state: LoadingState<WeatherData> = .idle
    
    @Published var weatherData: WeatherData?
    @Published private(set) var userLocation: CLLocationCoordinate2D?
    @Published private(set) var locationError: LocationError?
    private var cancellables = Set<AnyCancellable>()
    
    private let getCurrentWeatherUseCase: GetCurrentWeatherUseCase
    private let getUserLocationUseCase: GetUserLocationUseCase
    
    
    init(getCurrentWeatherUseCase: GetCurrentWeatherUseCase,
         getUserLocationUseCase: GetUserLocationUseCase) {
        self.getCurrentWeatherUseCase = getCurrentWeatherUseCase
        self.getUserLocationUseCase = getUserLocationUseCase
    }
    
    func getCurrentWeather(location: CLLocationCoordinate2D) {
        getCurrentWeatherUseCase.getCurrentWeather(params: OneCallRequestParams(location: location))
            .map { weatherData -> WeatherData in
            print(weatherData)
            return weatherData
            }.sink(receiveCompletion: { _ in
//                print($0)
            }, receiveValue: { weatherData in
                self.weatherData = weatherData
                self.state = .loaded(weatherData)
                if let weatherInfo = weatherData.current.weather.first {
//                    self.getWeatherIcon(weatherInfo: weatherInfo)
                }
            })
            .store(in: &cancellables)
    }
    
    func getUserLocation() {
        state = .loading
        getUserLocationUseCase.requestWhenInUseAuthorization()
            .flatMap { self.getUserLocationUseCase.requestUserLocation() }
            .sink { completion in
                if case .failure(let error) = completion {
                    self.locationError = error
                }
            } receiveValue: { location in
                self.userLocation = location.coordinate
                self.getCurrentWeather(location: location.coordinate)
//                self.requestUserLocality(location: location)
            }
            .store(in: &cancellables)
    }
    
    func getWeatherHourly() -> [WeatherAttributes] {
        Array<WeatherAttributes>(weatherData?.hourly.prefix(24) ?? [])
    }
    
    func getWeatherDaily() -> [DailyWeatherAttributes] {
        Array(weatherData?.daily.prefix(10) ?? [])
    }

}
