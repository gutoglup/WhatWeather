//
//  ApiKey.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

protocol ApiKey {
    var apiKey: String { get }
}

struct ApiKeyImpl: ApiKey {
    var apiKey = "e3cdcdaae40cce7566b254c628a17a9e"
}
