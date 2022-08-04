//
//  LoadingState.swift
//  WhatWeather
//
//  Created by Augusto Reis on 03/08/22.
//

import Foundation

enum LoadingState<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}
