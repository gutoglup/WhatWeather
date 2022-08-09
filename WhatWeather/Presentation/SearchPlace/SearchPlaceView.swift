//
//  SearchPlaceView.swift
//  WhatWeather
//
//  Created by Augusto Reis on 08/08/22.
//

import SwiftUI

struct SearchPlaceView: View {
    
    @State var searchTextField: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TextField("", text: $searchTextField)
                    .placeholder("Search", when: searchTextField.isEmpty)
                    .padding()
                    .background(Color.primaryBrand)
                    .cornerRadius(6)
                    .padding(3)
                    .overlay(RoundedRectangle(cornerRadius: 6)
                        .stroke(
                            LinearGradient(
                                colors: [Color.quintenaryBrand.opacity(0.9), Color.quintenaryBrand.opacity(0.7)],
                                startPoint: .leading,
                                endPoint: .trailing),
                            lineWidth: 1))
                    .padding([.horizontal], 12)
                    .foregroundColor(Color.quartenaryBrand)
            }
        }
        .background(Color.tertiaryBrand)
    }
}

struct SearchPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlaceView()
    }
}
