//
//  DailyListView.swift
//  WhatWeather
//
//  Created by Augusto Reis on 08/08/22.
//

import SwiftUI

struct DailyListView: View {
    
    var title: String
    var dailyData: [DailyWeatherAttributes]
    
    var body: some View {
        VStack() {
            
            VStack(alignment: .leading) {
                Text(title.uppercased())
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .padding([.horizontal], 8)
                    .opacity(0.9)
                Divider().overlay(Color.quartenaryBrand)
                    .padding([.horizontal], 8)
                ForEach(dailyData) { daily in
                    VStack {
                        HStack {
                            Text(daily.dateFormatted)
                                .font(.system(size: 14, weight: .regular, design: .default))
                            Spacer()
                            Text(daily.temperature?.minFormatted ?? "")
                                .font(.system(size: 14, weight: .medium, design: .default))
                                .opacity(0.7)
                            
                            LinearGradient(colors: [.cyan, .yellow, .orange], startPoint: .leading, endPoint: .trailing)
                                .frame(width: 20, height: 4)
                                .mask(RoundedRectangle(cornerRadius: 8))
                                
                            Text(daily.temperature?.maxFormatted ?? "")
                                .font(.system(size: 14, weight: .medium, design: .default))
                        }
                        Divider().overlay(Color.quartenaryBrand)
                    }
                    .padding([.horizontal], 8)
                    .padding([.top], 4)
                    
                }
            }
            .padding([.vertical], 8)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(LinearGradient(colors: [Color.quartenaryBrand.opacity(0.8), Color.quartenaryBrand.opacity(0.6)], startPoint: .top, endPoint: .bottom))
                    .opacity(0.2))
        }
    }
}

struct DailyListView_Previews: PreviewProvider {
    static var previews: some View {
        DailyListView(title: "Previsão para 10 dias", dailyData: [
            DailyWeatherAttributes(currentTime: Int(Date().timeIntervalSince1970), sunrise: nil, sunset: nil, moonrise: nil, moonset: nil, moonphase: nil, temperature: DailyTemperature(day: 200, min: 100, max: 300, night: 0, eve: 0, morn: 0), feelsLike: DailyTemperature(day: 0, min: 0, max: 0, night: 0, eve: 0, morn: 0), pressure: 0, humidity: 0, dewPoint: 0, windSpeed: 0, windDeg: 0, weather: [], clouds: 0, pop: 0, rain: 0, uvi: 0),
            DailyWeatherAttributes(currentTime: Int(Date().addingTimeInterval(1000000).timeIntervalSince1970), sunrise: nil, sunset: nil, moonrise: nil, moonset: nil, moonphase: nil, temperature: DailyTemperature(day: 200, min: 100, max: 300, night: 0, eve: 0, morn: 0), feelsLike: DailyTemperature(day: 0, min: 0, max: 0, night: 0, eve: 0, morn: 0), pressure: 0, humidity: 0, dewPoint: 0, windSpeed: 0, windDeg: 0, weather: [], clouds: 0, pop: 0, rain: 0, uvi: 0)])
    }
}
