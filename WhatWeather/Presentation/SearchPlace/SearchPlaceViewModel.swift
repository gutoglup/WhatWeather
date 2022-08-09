//
//  SearchPlaceViewModel.swift
//  WhatWeather
//
//  Created by Augusto Reis on 09/08/22.
//

import Foundation
import Combine
import CoreLocation

final class SearchPlaceViewModel: ObservableObject {
    
    @Published var placemarks: [AddressLocation] = []
    @Published var placeName: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    private let getPlacesUseCase: GetPlacesUseCase
    
    init(getPlacesUseCase: GetPlacesUseCase) {
        self.getPlacesUseCase = getPlacesUseCase
        setup()
    }
    
    private func setup() {
        $placeName
            .filter({!$0.isEmpty})
            .debounce(for: .seconds(2), scheduler: DispatchQueue.main)
            .sink { placeName in
                self.getPlaces(name: placeName)
            }.store(in: &cancellables)
    }
    
    func getPlaces(name: String) {
        getPlacesUseCase.getPlaces(name: name)
            .sink { completion in
                print(completion)
            } receiveValue: { placemarks in
                self.placemarks = placemarks
                print(placemarks)
            }.store(in: &cancellables)
    }
    
}
