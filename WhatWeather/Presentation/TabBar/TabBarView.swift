//
//  TabBarView.swift
//  WhatWeather
//
//  Created by Augusto Reis on 08/08/22.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            DashboardView(
                viewModel:
                    DependencyInjectionContainer.shared.container
                    .resolve(DashboardViewModel.self)!)
            .tabItem {
                VStack {
                    Image(systemName: "house")
                        .renderingMode(.template)
                    Text("Dashboard")
                }
            }
            SearchPlaceView(
                viewModel:
                    DependencyInjectionContainer.shared.container
                    .resolve(SearchPlaceViewModel.self)!)
            .tabItem{
                VStack {
                    Image(systemName: "magnifyingglass")
                            .renderingMode(.template)
                        Text("Search")
                    }
                }
        }.onAppear {
            UITabBar.appearance().backgroundColor = UIColor(Color.primaryBrand)
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.neutralBrand)
        }
            
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
