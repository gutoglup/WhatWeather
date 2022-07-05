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
        
        VStack {
            HStack {
                Text("Location: \(String(describing: dashboardViewModel.placemark?.name ?? ""))")
            }
        }
        .navigationTitle("WhatWeather")
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
