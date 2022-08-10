//
//  GetPlacesUseCase.swift
//  WhatWeather
//
//  Created by Augusto Reis on 09/08/22.
//

import Combine
import CoreLocation

protocol GetPlacesUseCase {
    func getPlaces(name: String) -> AnyPublisher<[AddressLocation], Error>
}

struct GetPlacesUseCaseImpl: GetPlacesUseCase {
    
    private let repository: GeocoderRepository
    private let limitRows = 20
    
    init(repository: GeocoderRepository) {
        self.repository = repository
    }
    
    func getPlaces(name: String) -> AnyPublisher<[AddressLocation], Error> {
        let params = DirectGeocodingParams(cityName: name, limit: limitRows)
        return repository.getPlaces(params: params)
    }
}
