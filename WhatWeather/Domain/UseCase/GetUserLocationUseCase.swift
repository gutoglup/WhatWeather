//
//  GetUserLocationUseCase.swift
//  WhatWeather
//
//  Created by Augusto Reis on 05/07/22.
//

import CoreLocation
import Combine

protocol GetUserLocationUseCase {
    func requestUserLocation() -> AnyPublisher<CLLocation, LocationError>
    func requestWhenInUseAuthorization() -> AnyPublisher<Void, LocationError>
    func requestUserLocality(location: CLLocation) -> AnyPublisher<CLPlacemark, LocationError>
}

final class GetUserLocationUseCaseImpl: NSObject, GetUserLocationUseCase {
    
    private let locationManager: CLLocationManager
    private var locationRequest = PassthroughSubject<CLLocation, LocationError>()
    private var authorizationRequest = PassthroughSubject<Void, LocationError>()
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }
    
    func requestUserLocation() -> AnyPublisher<CLLocation, LocationError> {
        guard locationManager.authorizationStatus == .authorizedAlways ||
                locationManager.authorizationStatus == .authorizedWhenInUse else {
            locationRequest.send(completion: .failure(.unauthorized))
            locationRequest.send(completion: .finished)
            return locationRequest.eraseToAnyPublisher()
        }
        
        locationManager.requestLocation()
        return locationRequest.eraseToAnyPublisher()
        
    }
    
    func requestWhenInUseAuthorization() -> AnyPublisher<Void, LocationError> {
        guard locationManager.authorizationStatus == .notDetermined else {
            authorizationRequest.send(())
            return authorizationRequest.eraseToAnyPublisher()
        }
        
        locationManager.requestWhenInUseAuthorization()
        return authorizationRequest.eraseToAnyPublisher()
    }
    
    func requestUserLocality(location: CLLocation) -> AnyPublisher<CLPlacemark, LocationError> {
        let placemarkRequest = PassthroughSubject<CLPlacemark, LocationError>()
        let geocoder = CLGeocoder()
        
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

extension GetUserLocationUseCaseImpl: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        locationRequest.send(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError,
           error.code == .denied {
            locationRequest.send(completion: .failure(.unauthorized))
        } else {
            locationRequest.send(completion: .failure(.unableToDetermineLocation))
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationRequest.send(())
    }
}
