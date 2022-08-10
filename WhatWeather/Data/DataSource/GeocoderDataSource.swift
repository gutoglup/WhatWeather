//
//  GeocoderDataSource.swift
//  WhatWeather
//
//  Created by Augusto Reis on 09/08/22.
//

import CoreLocation
import Combine

protocol GeocoderDataSource {
    func getPlaces(params: DirectGeocodingParams) -> AnyPublisher<[AddressLocation], Error>
    func requestUserLocality(location: CLLocation) -> AnyPublisher<CLPlacemark, LocationError>
}
