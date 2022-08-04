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
                
                Spacer()
                
                List {
                    Section {
                        ForEach(weatherData.hourly[0..<24]) { hourWeather in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(dashboardViewModel.weatherDate(hourWeather))
                                        .font(.system(size: 10, weight: .light, design: .default))
                                    Text(dashboardViewModel.weatherHour(hourWeather))
                                }
                                Spacer()
                                Text(dashboardViewModel.temperatureDescription(hourWeather))
                                    .padding([.trailing], 8)
                            }
                        }
                    } header: {
                        Text("Hoje")
                            .font(.system(size: 24, weight: .medium, design: .default))
                    }
                }
                
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
