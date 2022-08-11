//
//  WeatherIconRepositoryImpl.swift
//  WhatWeather
//
//  Created by Augusto Reis on 11/08/22.
//

import Foundation
import Combine

struct WeatherIconRepositoryImpl: WeatherIconRepository {
    
    private let remoteDataSource: WeatherIconDataSource
    private let fileDataSource: WeatherIconDataSource
    
    init(remoteDataSource: WeatherIconDataSource,
         fileDataSource: WeatherIconDataSource) {
        self.remoteDataSource = remoteDataSource
        self.fileDataSource = fileDataSource
    }
    
    func getIcon(params: WeatherIconParams) -> AnyPublisher<URL, Error> {
        fileDataSource.getIcon(params: params)
            .tryCatch { error -> AnyPublisher<URL, Error> in
                guard let error = error as? FileManagerError,
                      error == .fileNotFound else { throw error }
                return self.remoteDataSource.getIcon(params: params)
            }.eraseToAnyPublisher()
    }
}
