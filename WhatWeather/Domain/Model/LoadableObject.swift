//
//  LoadableObject.swift
//  WhatWeather
//
//  Created by Augusto Reis on 03/08/22.
//

import Combine
import Foundation

protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load()
}
