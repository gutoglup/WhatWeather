//
//  CurrentWeatherView.swift
//  WhatWeather
//
//  Created by Augusto Reis on 18/08/22.
//

import SwiftUI

struct CurrentWeatherView: View {
    
    @StateObject var viewModel: CurrentWeatherViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: viewModel.getWeatherIconUrl())
            Text(viewModel.placemark?.locality ?? "")
                .padding([.leading, .trailing], .custom(.small))
                .font(.custom(.medium(.titleMedium)))
            Text(viewModel.currentTemperature())
                .font(.custom(.light(.titleLarge)))
                .padding([.bottom], .custom(.smallest))
            Text(viewModel.currentTemperatureDescription())
                .font(.custom(.regular(.caption)))
            HStack {
                Text("Max: \(viewModel.dailyMaxTemperature())")
                    .padding([.trailing], .custom(.smallest))
                Text("Min: \(viewModel.dailyMinTemperature())")
            }
            .font(.custom(.regular(.caption)))
        }
        .onAppear {
            viewModel.requestUserLocality()
            viewModel.getWeatherIcon()
        }
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(
            viewModel: DependencyInjectionContainer
                .shared.container.resolve(
                    CurrentWeatherViewModel.self,
                    argument: WeatherData.fixture())!)
    }
}
