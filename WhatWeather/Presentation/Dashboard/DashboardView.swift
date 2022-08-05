//
//  DashboardView.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import SwiftUI
import Swinject

struct DashboardView: View {
    
    @StateObject var dashboardViewModel: DashboardViewModel
    
    var body: some View {
        
        switch dashboardViewModel.state {
        case .idle:
            Color.clear.onAppear(perform: dashboardViewModel.getUserLocation)
        case .loading:
            ProgressView()
        case .failed(let error):
            ErrorView(error: error, retryAction: dashboardViewModel.getUserLocation)
        case .loaded(let weatherData):
            VStack(alignment: .leading) {
                VStack(alignment: .center) {
                    Text(dashboardViewModel.placemark?.locality ?? "")
                        .padding([.leading, .trailing], 8)
                        .padding(.top, 32)
                        .font(.system(size: 24, weight: .medium, design: .default))
                    Text(dashboardViewModel.currentTemperature(weatherData))
                        .font(.system(size: 42, weight: .light, design: .default))
                        .padding([.bottom], 4)
                    Text(dashboardViewModel.currentTemperatureDescription(weatherData))
                        .font(.caption)
                    HStack {
                        Text("Max: \(dashboardViewModel.dailyMaxTemperature(weatherData))")
                            .padding([.trailing], 4)
                        Text("Min: \(dashboardViewModel.dailyMinTemperature(weatherData))")
                    }
                    .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding([.bottom], 12)
                
                
                
                HourlyListView(title: "Hoje", hourlyData: dashboardViewModel.getWeatherHourly())
                    .padding([.horizontal], 12)
                Spacer()
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(
            dashboardViewModel: DependencyInjectionContainer
                .shared.container.resolve(DashboardViewModel.self)!)
    }
}
