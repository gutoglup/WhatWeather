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
        
        VStack(alignment: .leading) {
            VStack(alignment: .center) {
                Text(dashboardViewModel.placemark?.locality ?? "")
                    .padding([.leading, .trailing], 8)
                    .padding(.top, 32)
                    .font(.system(size: 24, weight: .medium, design: .default))
                Text(dashboardViewModel.currentTemperature())
                    .font(.system(size: 42, weight: .light, design: .default))
                    .padding([.bottom], 4)
                Text(dashboardViewModel.currentTemperatureDescription())
                    .font(.caption)
                HStack {
                    Text("Max: \(dashboardViewModel.dailyMaxTemperature())")
                        .padding([.trailing], 4)
                    Text("Min: \(dashboardViewModel.dailyMinTemperature())")
                }
                .font(.caption)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        .onAppear(perform: dashboardViewModel.getUserLocation)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(
            dashboardViewModel: DependencyInjectionContainer
                .shared.container.resolve(DashboardViewModel.self)!)
    }
}
