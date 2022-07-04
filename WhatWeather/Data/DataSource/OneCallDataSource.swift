//
//  OneCallDataSource.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import Moya
import CombineMoya
import Combine

protocol OneCallDataSource {
    
    func getCurrentWeather(params: OneCallRequestParams) -> AnyPublisher<WeatherData, Error>
}
