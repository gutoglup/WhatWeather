//
//  WeatherIconRemoteDataSource.swift
//  WhatWeather
//
//  Created by Augusto Reis on 11/08/22.
//

import Combine
import Moya
import Foundation

struct WeatherIconRemoteDataSource: WeatherIconDataSource {
    
    private let provider: MoyaProvider<WeatherIconRouter>
    private let settings: NetworkSettings
    
    init(provider: MoyaProvider<WeatherIconRouter>,
         settings: NetworkSettings) {
        self.provider = provider
        self.settings = settings
    }
    
    func getIcon(params: WeatherIconParams) -> AnyPublisher<URL, Error> {
        let route = WeatherIconRoute.icon(params: params)
        let router: WeatherIconRouter = .init(route: route, settings: settings)
        return provider.requestPublisher(router)
            .tryMap(\.response)
            .tryMap({ _ in
                params.name.urlPathFromDocuments(fileExtension: params.pathExtension)
            })
            .eraseToAnyPublisher()
    }
}
