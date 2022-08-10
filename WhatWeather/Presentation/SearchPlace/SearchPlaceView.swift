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
        
        VStack(alignment: .leading) {
            TextField("Search", text: $viewModel.placeName)
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
            switch viewModel.state {
            case .idle:
                Text("Type a city name to search")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .failed(let error):
                ErrorView(error: error, retryAction: {})
            case .loaded(let addressesLocation):
                ScrollView {
                    ForEach(addressesLocation) { addressLocation in
                        SearchPlaceCell(addressLocation: addressLocation)
                    }.offset(x: 0, y: 12)
                }
                .background(Color.quartenaryBrand.mask(RoundedRectangle(cornerRadius: 10)))
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
