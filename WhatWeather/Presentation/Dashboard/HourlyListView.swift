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
                                    .font(.system(size: 12, weight: .light, design: .default))
                                
                                Text(hourWeather.temperatureFormatted)
                                    .font(.system(size: 20, weight: .regular, design: .default))
                            }
                            .padding(8)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 4, style: .continuous)
                                .fill(Color.cyan).opacity(0.2))
                    }
                }
            }
        }
    }
}


struct HourlyListView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyListView(title: "Hoje",
                       hourlyData: [
            WeatherAttributes(currentTime: Int(Date().timeIntervalSince1970), sunrise: nil, sunset: nil, temperature: 300, feelsLike: 100, pressure: 0, humidity: 0, dewPoint: 0, uvi: 0, clouds: 0, visibility: 0, windSpeed: 0, windDeg: 0, windGust: nil, weather: []),
            WeatherAttributes(currentTime: Int(Date().timeIntervalSince1970), sunrise: nil, sunset: nil, temperature: 300, feelsLike: 100, pressure: 0, humidity: 0, dewPoint: 0, uvi: 0, clouds: 0, visibility: 0, windSpeed: 0, windDeg: 0, windGust: nil, weather: [])
        ])
    }
}
