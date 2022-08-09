//
//  View+Extension.swift
//  WhatWeather
//
//  Created by Augusto Reis on 09/08/22.
//

import SwiftUI

extension View {
    func placeholder<Content:View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment, content: {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        })
    }
    
    func placeholder(_ text: String, when shouldShow: Bool, alignment: Alignment = .leading) -> some View {
        placeholder(when: shouldShow, alignment: alignment) {
            Text(text).foregroundColor(Color.quartenaryBrand)
        }
    }
}
