//
//  GeocodeRepositoryImpl.swift
//  WhatWeather
//
//  Created by Augusto Reis on 09/08/22.
//

import Combine
import CoreLocation

struct GeocoderRepositoryImpl: GeocoderRepository {
    
    private let dataSource: GeocoderDataSource
    
    init(dataSource: GeocoderDataSource) {
        self.dataSource = dataSource
    }
    
    func getPlaces(params: DirectGeocodingParams) -> AnyPublisher<[AddressLocation], Error> {
        dataSource.getPlaces(params: params)
    }
    
    func requestUserLocality(location: CLLocation) -> AnyPublisher<CLPlacemark, LocationError> {
        dataSource.requestUserLocality(location: location)
    }
}
