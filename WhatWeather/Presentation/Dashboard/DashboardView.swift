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
                .frameWidthHeightInfinity()
                .background(Color.tertiaryBrand)
        case .failed(let error):
            ErrorView(error: error, retryAction: viewModel.getUserLocation)
        case .loaded(let weatherData):
            ScrollView {
                VStack(alignment: .center) {
                    AsyncImage(url: viewModel.getWeatherIconUrl(weatherData))
                    Text(viewModel.placemark?.locality ?? "")
                        .padding([.leading, .trailing], .custom(.small))
                        .padding(.top, .custom(.extraLargest))
                        .font(.custom(.medium(.titleMedium)))
                    Text(viewModel.currentTemperature(weatherData))
                        .font(.custom(.light(.titleLarge)))
                        .padding([.bottom], .custom(.smallest))
                    Text(viewModel.currentTemperatureDescription(weatherData))
                        .font(.custom(.regular(.caption)))
                    HStack {
                        Text("Max: \(viewModel.dailyMaxTemperature(weatherData))")
                            .padding([.trailing], .custom(.smallest))
                        Text("Min: \(viewModel.dailyMinTemperature(weatherData))")
                    }
                    .font(.custom(.regular(.caption)))
                }
                .foregroundColor(Color.white)
                .frameWidthInfinity()
                .padding([.bottom], .custom(.medium))
            
                HourlyListView(title: "Hoje", hourlyData: viewModel.getWeatherHourly())
                    .padding([.horizontal], .custom(.small))
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

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(
            viewModel: DependencyInjectionContainer
                .shared.container.resolve(DashboardViewModel.self)!)
    }
}


