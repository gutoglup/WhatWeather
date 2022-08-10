//
//  GeocoderRemoteDataSource.swift
//  WhatWeather
//
//  Created by Augusto Reis on 09/08/22.
//

import Combine
import CoreLocation
import Moya

struct GeocoderRemoteDataSource: GeocoderDataSource {
    
    private let geocoder: CLGeocoder
    private let provider: MoyaProvider<GeocoderRouter>
    private let settings: NetworkSettings
    
    init(geocoder: CLGeocoder,
         provider: MoyaProvider<GeocoderRouter>,
         settings: NetworkSettings) {
        self.geocoder = geocoder
        self.provider = provider
        self.settings = settings
    }
    
    func getPlaces(params: DirectGeocodingParams) -> AnyPublisher<[AddressLocation], Error> {
        let route = GeocoderRoute.directGeocoding(params: params)
        let router: GeocoderRouter = .init(route: route, settings: settings)
        return provider.requestPublisher(router)
            .tryMap(\.data)
            .decode(type: [AddressLocation].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
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
