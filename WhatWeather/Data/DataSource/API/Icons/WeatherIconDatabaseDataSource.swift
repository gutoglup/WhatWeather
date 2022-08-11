//
//  WeatherIconDatabaseDataSource.swift
//  WhatWeather
//
//  Created by Augusto Reis on 11/08/22.
//

import Combine
import Foundation

struct WeatherIconDatabaseDataSource: WeatherIconDataSource {
    
    private let fileManager: FileManager
    
    init(fileManager: FileManager) {
        self.fileManager = fileManager
    }
    
    func getIcon(params: WeatherIconParams) -> AnyPublisher<URL, Error> {
        let urlPath = params.name.urlPathFromDocuments(fileExtension: params.pathExtension)
        if fileManager.fileExists(atPath: urlPath.path) {
            return Just(urlPath)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Empty(completeImmediately: false).eraseToAnyPublisher()
//            return Fail(error: FileManagerError.fileNotFound)
//                .eraseToAnyPublisher()
        }
    }
}
