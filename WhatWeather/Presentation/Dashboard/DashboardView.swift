//
//  DashboardView.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import SwiftUI
import Swinject

struct DashboardView: View {
    
    @StateObject var viewModel: DashboardViewModel
    
    var body: some View {
        
        switch viewModel.state {
        case .idle:
            Color.tertiaryBrand.onAppear(perform: viewModel.getUserLocation)
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.tertiaryBrand)
        case .failed(let error):
            ErrorView(error: error, retryAction: viewModel.getUserLocation)
        case .loaded(let weatherData):
            ScrollView {
                VStack(alignment: .center) {
                    Text(viewModel.placemark?.locality ?? "")
                        .padding([.leading, .trailing], 8)
                        .padding(.top, 32)
                        .font(.custom(.medium(.titleMedium)))
                    Text(viewModel.currentTemperature(weatherData))
                        .font(.custom(.light(.titleLarge)))
                        .padding([.bottom], 4)
                    Text(viewModel.currentTemperatureDescription(weatherData))
                        .font(.custom(.regular(.caption)))
                    HStack {
                        Text("Max: \(viewModel.dailyMaxTemperature(weatherData))")
                            .padding([.trailing], 4)
                        Text("Min: \(viewModel.dailyMinTemperature(weatherData))")
                    }
                    .font(.custom(.regular(.caption)))
                }
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding([.bottom], 12)
            
                HourlyListView(title: "Hoje", hourlyData: viewModel.getWeatherHourly())
                    .padding([.horizontal], 12)
                    .padding([.vertical], 18)
                    .foregroundColor(Color.white)
                DailyListView(title: "Previsão para 10 dias", dailyData: viewModel.getWeatherDaily())
                    .padding([.horizontal], 12)
                    .foregroundColor(Color.white)
            }
            .background(Color.tertiaryBrand)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(
            viewModel: DependencyInjectionContainer
                .shared.container.resolve(DashboardViewModel.self)!)
    }
}


