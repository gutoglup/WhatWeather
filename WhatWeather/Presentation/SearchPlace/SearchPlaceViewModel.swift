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
    
    @Published private(set) var state: LoadingState<[AddressLocation]> = .idle
    
    @Published var placeName: String = ""
    private var cancellables = Set<AnyCancellable>()
    private var addressesLocation: [AddressLocation] = []
    
    private let getPlacesUseCase: GetPlacesUseCase
    
    init(getPlacesUseCase: GetPlacesUseCase) {
        self.getPlacesUseCase = getPlacesUseCase
        setup()
    }
    
    private func setup() {
        $placeName
            .filter({!$0.isEmpty})
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { placeName in
                self.getPlaces(name: placeName)
            }.store(in: &cancellables)
    }
    
    func getPlaces(name: String) {
        state = .loading
        getPlacesUseCase.getPlaces(name: name)
            .sink { completion in
                print(completion)
                if case .failure(let error) = completion {
                    self.state = .failed(error)
                }
            } receiveValue: { addressesLocation in
                self.addressesLocation = addressesLocation
                self.state = .loaded(addressesLocation)
            }.store(in: &cancellables)
    }
    
}
