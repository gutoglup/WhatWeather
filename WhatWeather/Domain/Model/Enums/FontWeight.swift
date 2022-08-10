//
//  FontWeight.swift
//  WhatWeather
//
//  Created by Augusto Reis on 10/08/22.
//

import SwiftUI

enum FontWeight {
    
    case thin(_ size: FontSize)
    case light(_ size: FontSize)
    case medium(_ size: FontSize)
    case regular(_ size: FontSize)
    case bold(_ size: FontSize)
    
    var system: Font.Weight {
        switch self {
        case .thin:
            return Font.Weight.thin
        case .light:
            return Font.Weight.light
        case .medium:
            return Font.Weight.medium
        case .regular:
            return Font.Weight.regular
        case .bold:
            return Font.Weight.bold
        }
    }
    
}
