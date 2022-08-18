//
//  TranslucentButtonStyle.swift
//  WhatWeather
//
//  Created by Augusto Reis on 18/08/22.
//

import SwiftUI

struct TranslucentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom(.medium(.bodySmall)))
            .foregroundColor(.neutralBrand)
            .padding(.custom(.small))
            .background(
                Color.primaryBrand
                    .opacity(0.2)
                    .cornerRadius(8))
            .opacity(configuration.isPressed ? 0.7 : 1)
            .animation(.easeOut(duration: 0.5), value: configuration.isPressed)
    }
}
