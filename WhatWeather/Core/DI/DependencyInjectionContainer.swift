//
//  DependencyInjectionContainer.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import Swinject
import Moya
import SwiftUI

final class DependencyInjectionContainer {
    
    static let shared = DependencyInjectionContainer()
    
    var container: Container
    
    init() {
        self.container = Container()
        buildContainer()
    }
    
    func buildContainer() {
        container.register(DashboardViewModel.self) { resolver in
            DashboardViewModel(getCurrentWeatherUseCase: resolver.resolve(GetCurrentWeatherUseCase.self)!)
        }
        
        container.register(GetCurrentWeatherUseCase.self) { resolver in
            GetCurrentWeatherUseCaseImpl(repository: resolver.resolve(OneCallRepository.self)!)
        }
        
        container.register(OneCallRepository.self) { resolver in
            OneCallRepositoryImpl(dataSource: resolver.resolve(OneCallDataSource.self)!)
        }
        
        container.register(OneCallDataSource.self) { resolver in
            OneCallRemoteDataSource(provider: MoyaProvider<OneCallRouter>(plugins: [NetworkLoggerPlugin()]),
                                    settings: NetworkSettings(apiKey: resolver.resolve(ApiKey.self)!))
        }
        
        container.register(ApiKey.self) { resolver in
            ApiKeyImpl()
        }
    }
}
