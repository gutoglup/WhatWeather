//
//  CurrentWeatherDataSourceImpl.swift
//  WhatWeather
//
//  Created by Augusto Reis on 02/07/22.
//

import Foundation
import Moya
import CombineMoya
import Combine

struct OneCallRemoteDataSource: OneCallDataSource {
    
    private let provider: MoyaProvider<OneCallRouter>
    private let settings: NetworkSettings
    
    func getCurrentWeather(params: OneCallRequestParams) -> AnyPublisher<WeatherData, Error> {
        let route = OneCallRoute.currentWeather(params: params)
        let router: OneCallRouter = .init(route: route, settings: settings)
        return provider.requestPublisher(router)
            .tryMap(\.data)
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
