//
//  FileManagerError.swift
//  WhatWeather
//
//  Created by Augusto Reis on 11/08/22.
//

import Foundation

enum FileManagerError: LocalizedError {
    case fileNotFound
    
    var errorDescription: String? {
        "File not found"
    }
}
