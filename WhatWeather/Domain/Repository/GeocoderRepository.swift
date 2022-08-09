//
//  GeocoderRepository.swift
//  WhatWeather
//
//  Created by Augusto Reis on 09/08/22.
//

import Combine
import CoreLocation

protocol GeocoderRepository {
    func getPlaces(name: String) -> AnyPublisher<[AddressLocation], LocationError>
    func requestUserLocality(location: CLLocation) -> AnyPublisher<CLPlacemark, LocationError>
}
