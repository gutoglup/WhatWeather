//
//  HourlyListView.swift
//  WhatWeather
//
//  Created by Augusto Reis on 05/08/22.
//

import SwiftUI

struct HourlyListView: View {
    
    var title: String
    var hourlyData: [WeatherAttributes]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 24, weight: .medium, design: .default))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(hourlyData) { hourWeather in
                        ZStack {
                            VStack(alignment: .center) {
                                Text(hourWeather.hourFormatted)
                                    .font(.custom(.light(.bodySmall)))
                                Text(hourWeather.temperatureFormatted)
                                    .font(.custom(.regular(.titleSmall)))
                            }
                            .padding(8)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 4, style: .continuous)
                                .fill(LinearGradient(colors: [Color.quartenaryBrand.opacity(0.8), Color.quartenaryBrand.opacity(0.6)], startPoint: .top, endPoint: .bottom))
                                .opacity(0.3))
                    }
                }
            }
        }
    }
}


struct HourlyListView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyListView(title: "Hoje",
                       hourlyData: Array(repeating: WeatherAttributes.fixture(), count: 5))
    }
}
