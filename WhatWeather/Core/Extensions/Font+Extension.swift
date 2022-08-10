//
//  Font+Extension.swift
//  WhatWeather
//
//  Created by Augusto Reis on 10/08/22.
//

import SwiftUI

@available(iOS 13.0,*)
extension Font {
    
    static func custom(_ weight: FontWeight) -> Font {
        switch weight {
        case .thin(let size), .light(let size), .medium(let size), .regular(let size), .bold(let size):
            return custom(size, weight)
        }
    }
    
    static func custom(_ size: FontSize, _ weight: FontWeight) -> Font {
        Self.system(size: size.rawValue, weight: weight.system, design: .default)
    }
}
