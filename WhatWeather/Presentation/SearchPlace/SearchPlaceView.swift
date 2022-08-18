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
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Search", text: $viewModel.placeName)
                    .placeholder("Search", when: viewModel.placeName.isEmpty)
                    .padding()
                    .background(Color.primaryBrand)
                    .cornerRadius(6)
                    .padding(.custom(.smallest))
                    .overlay(RoundedRectangle(cornerRadius: 6)
                        .stroke(
                            LinearGradient(
                                colors: [Color.quintenaryBrand.opacity(0.9), Color.quintenaryBrand.opacity(0.7)],
                                startPoint: .leading,
                                endPoint: .trailing),
                            lineWidth: 1))
                    .padding([.horizontal], .custom(.medium))
                    .foregroundColor(Color.quartenaryBrand)
                switch viewModel.state {
                case .idle:
                    Text("Type a city name to search")
                        .frameWidthHeightInfinity()
                        
                case .loading:
                    ProgressView()
                        .frameWidthHeightInfinity()
                case .failed(let error):
                    ErrorView(error: error, retryAction: {})
                case .loaded(let addressesLocation):
                    
                    ScrollView {
                        ForEach(addressesLocation) { addressLocation in
                            NavigationLink(destination: PlaceDetailView(viewModel: DependencyInjectionContainer.shared.container.resolve(
                                PlaceDetailViewModel.self,
                                argument: addressLocation.coordinates)!) ){
                                    SearchPlaceCell(addressLocation: addressLocation)
                                }
                        }.offset(x: .custom(.none),
                                 y: .custom(.medium))
                    }
                    .background(Color.quartenaryBrand.mask(RoundedRectangle(cornerRadius: 10)))
                }
                
            }
            .background(Color.tertiaryBrand)
            .navigationBarHidden(true)
            
        }
        
        
    }
}

struct SearchPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlaceView(viewModel: DependencyInjectionContainer
            .shared.container.resolve(SearchPlaceViewModel.self)!)
    }
}
