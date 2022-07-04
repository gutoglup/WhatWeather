//
//  CurrentWeatherRouter.swift
//  WhatWeather
//
//  Created by Augusto Reis on 02/07/22.
//

import Foundation
import Moya

enum OneCallRoute {
    case currentWeather(params: OneCallRequestParams)
}

struct OneCallRouter: TargetType {
    
    private let route: OneCallRoute
    private let settings: NetworkSettings
    
    init(route: OneCallRoute, settings: NetworkSettings) {
        self.route = route
        self.settings = settings
    }
    
    var baseURL: URL { try! Constants.Networking.oneCallVersionApiUrl.asURL() }
    
    var path: String {
        switch route {
        case .currentWeather:
            return "/onecall"
        }
    }
    
    var method: Moya.Method { .get }
    
    var task: Task {
        switch route {
        case .currentWeather(let params):
            return .requestParameters(
                parameters: [
                    "lat": params.location.latitude,
                    "lon": params.location.longitude,
                    "appid": settings.apiKey.apiKey],
                encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]?
}
