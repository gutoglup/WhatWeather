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
    @Published var placemark: CLPlacemark?
    @Published private(set) var userLocation: CLLocationCoordinate2D?
    @Published private(set) var locationError: LocationError?
    private var cancellables = Set<AnyCancellable>()
    
    private let getCurrentWeatherUseCase: GetCurrentWeatherUseCase
    private let getUserLocationUseCase: GetUserLocationUseCase
    private let getUserAddressUseCase: GetUserAddressUseCase
    private let getWeatherIconUseCase: GetWeatherIconUseCase
    
    init(getCurrentWeatherUseCase: GetCurrentWeatherUseCase,
         getUserLocationUseCase: GetUserLocationUseCase,
         getUserAddressUseCase: GetUserAddressUseCase,
         getWeatherIconUseCase: GetWeatherIconUseCase) {
        self.getCurrentWeatherUseCase = getCurrentWeatherUseCase
        self.getUserLocationUseCase = getUserLocationUseCase
        self.getUserAddressUseCase = getUserAddressUseCase
        self.getWeatherIconUseCase = getWeatherIconUseCase
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
                    self.getWeatherIcon(weatherInfo: weatherInfo)
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
                self.requestUserLocality(location: location)
            }
            .store(in: &cancellables)
    }
    
    private func requestUserLocality(location: CLLocation) {
        getUserAddressUseCase.requestUserLocality(location: location)
            .sink { _ in

            } receiveValue: { placemark in
                self.placemark = placemark
            }.store(in: &cancellables)

    }
    
    func getWeatherIcon(weatherInfo: WeatherInfo) {
        getWeatherIconUseCase.getIcon(name: weatherInfo.icon)
            .sink { completion in
                print(completion)
            } receiveValue: { iconUrl in
                if self.weatherData != nil {
                    self.weatherData!.current.weather[0].iconUrl = iconUrl
                    self.state = .loaded(self.weatherData!)
                }
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
    
    func getWeatherIconUrl(_ weatherData: WeatherData) -> UIImage {
        let path = weatherData.current.weather.first?.iconUrl?.path ?? ""
        guard let image = UIImage(contentsOfFile: path) else {
            return UIImage()
        }
        return image
    }
}
