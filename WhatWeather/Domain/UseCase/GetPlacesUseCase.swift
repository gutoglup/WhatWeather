//
//  GetPlacesUseCase.swift
//  WhatWeather
//
//  Created by Augusto Reis on 09/08/22.
//

import Combine
import CoreLocation

protocol GetPlacesUseCase {
    func getPlaces(name: String) -> AnyPublisher<[AddressLocation], LocationError>
}

struct GetPlacesUseCaseImpl: GetPlacesUseCase {
    
    private let repository: GeocoderRepository
    
    init(repository: GeocoderRepository) {
        self.repository = repository
    }
    
    func getPlaces(name: String) -> AnyPublisher<[AddressLocation], LocationError> {
        repository.getPlaces(name: name)
    }
}
