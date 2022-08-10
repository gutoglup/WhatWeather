//
//  GeocoderRepository.swift
//  WhatWeather
//
//  Created by Augusto Reis on 09/08/22.
//

import Combine
import CoreLocation

protocol GeocoderRepository {
    func getPlaces(params: DirectGeocodingParams) -> AnyPublisher<[AddressLocation], Error>
    func requestUserLocality(location: CLLocation) -> AnyPublisher<CLPlacemark, LocationError>
}
