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
    
    init() {
        self.container = Container()
        buildContainer()
    }
    
    func buildContainer() {
        // MARK: - View model
        
        container.register(DashboardViewModel.self) { resolver in
            DashboardViewModel(
                getCurrentWeatherUseCase: resolver.resolve(GetCurrentWeatherUseCase.self)!,
                getUserLocationUseCase: resolver.resolve(GetUserLocationUseCase.self)!,
                getUserAddressUseCase: resolver.resolve(GetUserAddressUseCase.self)!)
        }
        
        container.register(SearchPlaceViewModel.self) { resolver in
            SearchPlaceViewModel(
                getPlacesUseCase: resolver.resolve(GetPlacesUseCase.self)!)
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
        
        // MARK: - Repository
        
        container.register(GeocoderRepository.self) { resolver in
            GeocoderRepositoryImpl(dataSource: resolver.resolve(GeocoderDataSource.self)!)
        }
        
        container.register(OneCallRepository.self) { resolver in
            OneCallRepositoryImpl(dataSource: resolver.resolve(OneCallDataSource.self)!)
        }
        
        // MARK: - Data source
        
        container.register(GeocoderDataSource.self) { _ in
            GeocoderRemoteDataSource(geocoder: CLGeocoder())
        }
        
        container.register(OneCallDataSource.self) { resolver in
            OneCallRemoteDataSource(provider: MoyaProvider<OneCallRouter>(plugins: [NetworkLoggerPlugin()]),
                                    settings: NetworkSettings(apiKey: resolver.resolve(ApiKey.self)!))
        }
        
        // MARK: - Helpers
        
        container.register(ApiKey.self) { resolver in
            ApiKeyImpl()
        }
    }
}
