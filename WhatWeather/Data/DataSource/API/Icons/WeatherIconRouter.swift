//
//  WeatherIconRouter.swift
//  WhatWeather
//
//  Created by Augusto Reis on 11/08/22.
//

import Foundation
import Moya
import Alamofire

enum WeatherIconRoute {
    case icon(params: WeatherIconParams)
}

struct WeatherIconRouter: TargetType {
    
    private let route: WeatherIconRoute
    private let settings: NetworkSettings
    
    init(route: WeatherIconRoute, settings: NetworkSettings) {
        self.route = route
        self.settings = settings
    }
    
    var baseURL: URL { try! Constants.Networking.iconVersionApiUrl.asURL() }
    
    var path: String {
        switch route {
        case .icon(let params):
            return "/\(params.name)\(params.proportion).\(params.pathExtension)"
        }
    }
    
    var method: Moya.Method { .get }
    
    var task: Task {
        switch route {
        case .icon(let params):
            return .downloadDestination { temporaryURL, response in
                let fileUrl = params.name.urlPathFromDocuments(fileExtension: params.pathExtension)
                return (destinationURL: fileUrl, options: DownloadRequest.Options.removePreviousFile)
            }
        }
    }
    
    var headers: [String : String]?
}
