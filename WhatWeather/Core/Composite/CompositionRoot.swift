//
//  CompositionRoot.swift
//  WhatWeather
//
//  Created by Augusto Reis on 04/07/22.
//

import SwiftUI

enum CompositionRoot {
    
    static var composeApp: some View {
        NavigationView {
            DashboardView(
                dashboardViewModel: DependencyInjectionContainer
                    .shared.container.resolve(DashboardViewModel.self)!)
        }
    }
}
