//
//  Constants.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

struct Constants {
    
    enum Networking {
        static let baseUrl: String = "https://api.openweathermap.org"
        static let oneCallVersionApiUrl: String = "\(baseUrl)/data/2.5"
        static let geocodingVersionApiUrl: String = "\(baseUrl)/geo/1.0"
        static let iconVersionApiUrl: String = "\(baseUrl)/img/wn"
    }
    
}
