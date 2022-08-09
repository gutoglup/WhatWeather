//
//  GeocoderRemoteDataSource.swift
//  WhatWeather
//
//  Created by Augusto Reis on 09/08/22.
//

import Combine
import CoreLocation

struct GeocoderRemoteDataSource: GeocoderDataSource {
    
    private let geocoder: CLGeocoder
    
    init(geocoder: CLGeocoder) {
        self.geocoder = geocoder
    }
    
    func getPlaces(name: String) -> AnyPublisher<[AddressLocation], LocationError> {
        let placemarkRequest = PassthroughSubject<[AddressLocation], LocationError>()
        
        geocoder.geocodeAddressString(name) { placemarks, error in
            guard let placemarks = placemarks else {
                placemarkRequest.send(completion: .failure(.unableToSearchLocation))
                return
            }
            let addresses = placemarks.map { placemark -> AddressLocation in
                let coordinates = placemark.location?.coordinate
                return AddressLocation(
                    name: placemark.name ?? "",
                    latitude: coordinates?.latitude ?? 0,
                    longitude: coordinates?.longitude ?? 0)
            }
            placemarkRequest.send(addresses)
        }
        return placemarkRequest.eraseToAnyPublisher()
    }
    
    func requestUserLocality(location: CLLocation) -> AnyPublisher<CLPlacemark, LocationError> {
        let placemarkRequest = PassthroughSubject<CLPlacemark, LocationError>()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                placemarkRequest.send(completion: .failure(.unableToSearchLocation))
                placemarkRequest.send(completion: .finished)
            }
            guard let placemark = placemarks?.first else {
                return
            }
            placemarkRequest.send(placemark)
        }
        
        return placemarkRequest.eraseToAnyPublisher()
    }
}
