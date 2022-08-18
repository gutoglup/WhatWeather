//
//  CurrentWeatherViewModel.swift
//  WhatWeather
//
//  Created by Augusto Reis on 18/08/22.
//

import Foundation
import SwiftUI
import CoreLocation
import Combine

final class CurrentWeatherViewModel: ObservableObject {
    
    @Published var placemark: CLPlacemark?
    
    private let getUserAddressUseCase: GetUserAddressUseCase
    private let getWeatherIconUseCase: GetWeatherIconUseCase
    private var weatherData: WeatherData
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(getUserAddressUseCase: GetUserAddressUseCase,
         getWeatherIconUseCase: GetWeatherIconUseCase,
         weatherData: WeatherData) {
        self.getUserAddressUseCase = getUserAddressUseCase
        self.getWeatherIconUseCase = getWeatherIconUseCase
        self.weatherData = weatherData
    }
    
    func requestUserLocality() {
        let location = CLLocation(latitude: weatherData.latitude, longitude: weatherData.longitude)
        getUserAddressUseCase.requestUserLocality(location: location)
            .sink { _ in

            } receiveValue: { placemark in
                self.placemark = placemark
            }.store(in: &cancellables)
    }

    func getWeatherIcon() {
        guard let weatherInfo = weatherData.current.weather.first else {
            return
        }
        getWeatherIconUseCase.getIcon(name: weatherInfo.icon)
            .sink { completion in
                print(completion)
            } receiveValue: { iconUrl in
                self.weatherData.current.weather[0].iconUrl = iconUrl
                //                    self.state = .loaded(self.weatherData!)
            }.store(in: &cancellables)
    }
    
    func currentTemperature() -> String {
        weatherData.current.temperature.temperatureLocalized
    }
    
    func currentTemperatureDescription() -> String {
        weatherData.current.weather.first?.main ?? ""
    }
    
    func dailyMaxTemperature() -> String {
        weatherData.daily.first?.temperature?.max?.temperatureLocalized ?? ""
    }
    
    func dailyMinTemperature() -> String {
        weatherData.daily.first?.temperature?.min?.temperatureLocalized ?? ""
    }
    
    func getWeatherIconUrl() -> UIImage {
        let path = weatherData.current.weather.first?.iconUrl?.path ?? ""
        guard let image = UIImage(contentsOfFile: path) else {
            return UIImage()
        }
        return image
    }
}
