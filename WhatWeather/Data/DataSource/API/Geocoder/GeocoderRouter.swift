//
//  GeocoderRouter.swift
//  WhatWeather
//
//  Created by Augusto Reis on 10/08/22.
//

import Foundation
import Moya

enum GeocoderRoute {
    case directGeocoding(params: DirectGeocodingParams)
}

struct GeocoderRouter: TargetType {
    
    private let route: GeocoderRoute
    private let settings: NetworkSettings
    
    init(route: GeocoderRoute, settings: NetworkSettings) {
        self.route = route
        self.settings = settings
    }
    
    var baseURL: URL { try! Constants.Networking.geocodingVersionApiUrl.asURL() }
    
    var path: String {
        switch route {
        case .directGeocoding:
            return "/direct"
        }
    }
    
    var method: Moya.Method { .get }
    
    var task: Task {
        switch route {
        case .directGeocoding(let params):
            return .requestParameters(
                parameters: [
                    "q": params.cityName,
                    "limit": params.limit,
                    "appid": settings.apiKey.apiKey],
                encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]?
}
