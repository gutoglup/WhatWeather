//
//  PlaceDetailView.swift
//  WhatWeather
//
//  Created by Augusto Reis on 18/08/22.
//

import SwiftUI
#if DEBUG
    import CoreLocation
#endif

struct PlaceDetailView: View {
    
    @StateObject var viewModel: PlaceDetailViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.tertiaryBrand
                .frameWidthHeightInfinity()
                .background(Color.tertiaryBrand)
                .onAppear {
                    viewModel.getCurrentWeather()
                }
        case .loading:
            ProgressView()
                .frameWidthHeightInfinity()
                .background(Color.tertiaryBrand)
        case .failed(let error):
            ErrorView(error: error) {
                viewModel.getCurrentWeather()
            }
        case .loaded(let weatherData):
            ScrollView(.vertical) {
                CurrentWeatherView(
                    viewModel: DependencyInjectionContainer.shared.container.resolve(
                        CurrentWeatherViewModel.self, argument: weatherData)!)
                .foregroundColor(Color.white)
                .frameWidthInfinity()
                .padding([.bottom], .custom(.medium))
                
                HStack {
                    Button("Adicionar como localização padrão") {
                        // TODO: Add action here
                    }
                    .buttonStyle(TranslucentButtonStyle())
                    
                }
                
                HourlyListView(title: "Hoje", hourlyData: viewModel.getWeatherHourly())
                    .padding([.horizontal], .custom(.medium))
                    .padding([.vertical], .custom(.large))
                    .foregroundColor(Color.white)
                DailyListView(title: "Previsão para 10 dias", dailyData: viewModel.getWeatherDaily())
                    .padding([.horizontal], .custom(.medium))
                    .foregroundColor(Color.white)
            }
            .background(Color.tertiaryBrand)
        }
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView(
            viewModel: DependencyInjectionContainer.shared.container.resolve(
                PlaceDetailViewModel.self,
                argument: CLLocationCoordinate2D(latitude: 10.0, longitude: 11.0))!)
    }
}
