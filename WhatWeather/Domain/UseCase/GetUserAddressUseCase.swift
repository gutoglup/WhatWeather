//
//  GetUserAddressUseCase.swift
//  WhatWeather
//
//  Created by Augusto Reis on 09/08/22.
//

import Combine
import CoreLocation

protocol GetUserAddressUseCase {
    func requestUserLocality(location: CLLocation) -> AnyPublisher<CLPlacemark, LocationError>
}

struct GetUserAddressUseCaseImpl: GetUserAddressUseCase {
    
    private let repository: GeocoderRepository
    
    init(repository: GeocoderRepository) {
        self.repository = repository
    }
        
    func requestUserLocality(location: CLLocation) -> AnyPublisher<CLPlacemark, LocationError> {
        repository.requestUserLocality(location: location)
    }
    
}
