//
//  SearchPlaceView.swift
//  WhatWeather
//
//  Created by Augusto Reis on 08/08/22.
//

import SwiftUI
import Swinject

struct SearchPlaceView: View {
    
    @StateObject var viewModel: SearchPlaceViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TextField("", text: $viewModel.placeName)
                    .placeholder("Search", when: viewModel.placeName.isEmpty)
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
            ForEach(viewModel.placemarks) { placemark in
                Text(placemark.name)
            }
        }
        .background(Color.tertiaryBrand)
    }
}

struct SearchPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlaceView(viewModel: DependencyInjectionContainer
            .shared.container.resolve(SearchPlaceViewModel.self)!)
    }
}
