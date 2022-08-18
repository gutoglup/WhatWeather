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
                CurrentWeatherView(
                    viewModel: DependencyInjectionContainer
                        .shared.container.resolve(CurrentWeatherViewModel.self, argument: weatherData)!)
                .foregroundColor(Color.white)
                .frameWidthInfinity()
                .padding([.bottom], .custom(.medium))
            
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

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(
            viewModel: DependencyInjectionContainer
                .shared.container.resolve(DashboardViewModel.self)!)
    }
}


