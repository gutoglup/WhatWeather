//
//  DependencyInjectionContainer.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import Swinject
import Moya
import SwiftUI
import CoreLocation

final class DependencyInjectionContainer {
    
    static let shared = DependencyInjectionContainer()
    
    var container: Container
    
    private init() {
        self.container = Container()
        buildContainer()
    }
    
    func buildContainer() {
        // MARK: - View model
        
        container.register(DashboardViewModel.self) { resolver in
            DashboardViewModel(
                getCurrentWeatherUseCase: resolver.resolve(GetCurrentWeatherUseCase.self)!,
                getUserLocationUseCase: resolver.resolve(GetUserLocationUseCase.self)!)
        }
        
        container.register(SearchPlaceViewModel.self) { resolver in
            SearchPlaceViewModel(
                getPlacesUseCase: resolver.resolve(GetPlacesUseCase.self)!)
        }
        
        container.register(CurrentWeatherViewModel.self) { (resolver, weatherData: WeatherData) in
            CurrentWeatherViewModel(
                getUserAddressUseCase: resolver.resolve(GetUserAddressUseCase.self)!,
                getWeatherIconUseCase: resolver.resolve(GetWeatherIconUseCase.self)!,
                weatherData: weatherData)
        }
        
        container.register(PlaceDetailViewModel.self) { (resolver, coordinates: CLLocationCoordinate2D) in
            PlaceDetailViewModel(
                getCurrentWeatherUseCase: resolver.resolve(GetCurrentWeatherUseCase.self)!,
                location: coordinates)
        }
        
        // MARK: - Use case
        
        container.register(GetCurrentWeatherUseCase.self) { resolver in
            GetCurrentWeatherUseCaseImpl(repository: resolver.resolve(OneCallRepository.self)!)
        }
        
        container.register(GetPlacesUseCase.self) { resolver in
            GetPlacesUseCaseImpl(repository: resolver.resolve(GeocoderRepository.self)!)
        }
        
        container.register(GetUserAddressUseCase.self) { resolver in
            GetUserAddressUseCaseImpl(repository: resolver.resolve(GeocoderRepository.self)!)
        }
        
        container.register(GetUserLocationUseCase.self) { _ in
            GetUserLocationUseCaseImpl(locationManager: CLLocationManager())
        }
        
        container.register(GetWeatherIconUseCase.self) { resolver in
            GetWeatherIconUseCaseImpl(repository: resolver.resolve(WeatherIconRepository.self)!)
        }
        
        // MARK: - Repository
        
        container.register(GeocoderRepository.self) { resolver in
            GeocoderRepositoryImpl(dataSource: resolver.resolve(GeocoderDataSource.self)!)
        }
        
        container.register(OneCallRepository.self) { resolver in
            OneCallRepositoryImpl(dataSource: resolver.resolve(OneCallDataSource.self)!)
        }
        
        container.register(WeatherIconRepository.self) { resolver in
            WeatherIconRepositoryImpl(
                remoteDataSource: resolver.resolve(WeatherIconDataSource.self, name: DataSourceType.remote.rawValue)!,
                fileDataSource: resolver.resolve(WeatherIconDataSource.self, name: DataSourceType.database.rawValue)!)
        }
        
        // MARK: - Data source
        
        container.register(GeocoderDataSource.self) { resolver in
            GeocoderRemoteDataSource(geocoder: CLGeocoder(),
                                     provider: MoyaProvider<GeocoderRouter>(plugins: [NetworkLoggerPlugin()]),
                                     settings: NetworkSettings(apiKey: resolver.resolve(ApiKey.self)!))
        }
        
        container.register(OneCallDataSource.self) { resolver in
            OneCallRemoteDataSource(provider: MoyaProvider<OneCallRouter>(plugins: [NetworkLoggerPlugin()]),
                                    settings: NetworkSettings(apiKey: resolver.resolve(ApiKey.self)!))
        }
        
        container.register(WeatherIconDataSource.self, name: DataSourceType.database.rawValue) { resolver in
            WeatherIconDatabaseDataSource(fileManager: FileManager())
        }
        
        container.register(WeatherIconDataSource.self, name: DataSourceType.remote.rawValue) { resolver in
            WeatherIconRemoteDataSource(provider: MoyaProvider<WeatherIconRouter>(plugins: [NetworkLoggerPlugin()]),
                                        settings: NetworkSettings(apiKey: resolver.resolve(ApiKey.self)!))
        }
        
        // MARK: - Helpers
        
        container.register(ApiKey.self) { resolver in
            ApiKeyImpl()
        }
    }
}
