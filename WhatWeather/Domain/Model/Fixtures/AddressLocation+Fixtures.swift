//
//  AddressLocation+Fixtures.swift
//  WhatWeather
//
//  Created by Augusto Reis on 10/08/22.
//

extension AddressLocation {
    static func fixture(
        name: String = "London",
        latitude: Double = 12,
        longitude: Double = 10,
        state: String = "CA",
        country: String = "US"
    ) -> AddressLocation {
        .init(name: name, latitude: latitude, longitude: longitude, state: state, country: country)
    }
}
