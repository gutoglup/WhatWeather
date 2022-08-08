//
//  DashboardViewModel.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import Combine
import CoreLocation

final class DashboardViewModel: ObservableObject {
    
    @Published private(set) var state: LoadingState<WeatherData> = .idle
    
    @Published var weatherData: WeatherData?
    @Published var placemark: CLPlacemark?
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
            }.sink(receiveCompletion: {
                print($0)
            }, receiveValue: { weatherData in
                self.weatherData = weatherData
                self.state = .loaded(weatherData)
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
                self.requestUserLocality(location: location)
            }
            .store(in: &cancellables)
    }
    
    private func requestUserLocality(location: CLLocation) {
        getUserLocationUseCase.requestUserLocality(location: location)
            .sink { _ in

            } receiveValue: { placemark in
                self.placemark = placemark
            }.store(in: &cancellables)

    }
    
    func currentTemperature(_ weatherData: WeatherData) -> String {
        weatherData.current.temperature.temperatureLocalized
    }
    
    func dailyMaxTemperature(_ weatherData: WeatherData) -> String {
        weatherData.daily.first?.temperature?.max?.temperatureLocalized ?? ""
    }
    
    func dailyMinTemperature(_ weatherData: WeatherData) -> String {
        weatherData.daily.first?.temperature?.min?.temperatureLocalized ?? ""
    }
    
    func currentTemperatureDescription(_ weatherData: WeatherData) -> String {
        weatherData.current.weather.first?.main ?? ""
    }
    
    func getWeatherHourly() -> [WeatherAttributes] {
        Array<WeatherAttributes>(weatherData?.hourly.prefix(24) ?? [])
    }
    
    func getWeatherDaily() -> [DailyWeatherAttributes] {
        Array(weatherData?.daily.prefix(10) ?? [])
    }
}
