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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(perform: dashboardViewModel.getCurrentWeather)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(
            dashboardViewModel: DependencyInjectionContainer
                .shared.container.resolve(DashboardViewModel.self)!)
    }
}
