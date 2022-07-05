//
//  GetUserLocationUseCase.swift
//  WhatWeather
//
//  Created by Augusto Reis on 05/07/22.
//

import CoreLocation
import Combine

protocol GetUserLocationUseCase {
    func requestUserLocation() -> Future<CLLocation, LocationError>
    func requestWhenInUseAuthorization() -> Future<Void, LocationError>
    func requestUserLocality(location: CLLocation) -> Future<CLPlacemark, LocationError>
}

final class GetUserLocationUseCaseImpl: NSObject, GetUserLocationUseCase {
    
    private let locationManager: CLLocationManager
    private var authorizationRequests: [(Result<Void, LocationError>) -> Void] = []
    private var locationRequests: [(Result<CLLocation, LocationError>) -> Void] = []
    private var placemarksRequests: [(Result<CLPlacemark, LocationError>) -> Void] = []
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }
    
    func requestUserLocation() -> Future<CLLocation, LocationError> {
        guard locationManager.authorizationStatus == .authorizedAlways ||
                locationManager.authorizationStatus == .authorizedWhenInUse else {
            return Future { $0(.failure(.unauthorized)) }
        }
        
        let future = Future<CLLocation, LocationError> { completion in
            self.locationRequests.append(completion)
        }
        
        locationManager.requestLocation()
        return future
        
    }
    
    func requestWhenInUseAuthorization() -> Future<Void, LocationError> {
        guard locationManager.authorizationStatus == .notDetermined else {
            return Future { $0(.success(())) }
        }
        
        let future = Future<Void, LocationError> { completion in
            self.authorizationRequests.append(completion)
        }
        
        locationManager.requestWhenInUseAuthorization()
        return future
    }
    
    func requestUserLocality(location: CLLocation) -> Future<CLPlacemark, LocationError> {
        let geocoder = CLGeocoder()
        let future = Future<CLPlacemark, LocationError> { completion in
            self.placemarksRequests.append(completion)
        }
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            while !self.placemarksRequests.isEmpty {
                let result = self.placemarksRequests.removeFirst()
                if let error = error {
                    result(.failure(LocationError.unableToSearchLocation))
                }
                guard let placemark = placemarks?.first else {
                    return
                }
                result(.success(placemark))
            }
            
        }
        
        return future
    }
    
    private func handleUserLocationResult(_ result: Result<CLLocation, LocationError>) {
        while !locationRequests.isEmpty {
            let request = locationRequests.removeFirst()
            request(result)
        }
    }
    
}

extension GetUserLocationUseCaseImpl: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        handleUserLocationResult(.success(location))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError,
           error.code == .denied {
            handleUserLocationResult(.failure(LocationError.unauthorized))
        } else {
            handleUserLocationResult(.failure(LocationError.unableToDetermineLocation))
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        while !authorizationRequests.isEmpty {
            let request = authorizationRequests.removeFirst()
            request(.success(()))
        }
    }
}
