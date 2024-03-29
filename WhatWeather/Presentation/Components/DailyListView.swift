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
                    .font(.custom(.regular(.caption)))
                    .padding([.horizontal], .custom(.small))
                    .opacity(0.9)
                Divider().overlay(Color.quartenaryBrand)
                    .padding([.horizontal], .custom(.small))
                ForEach(dailyData) { daily in
                    VStack {
                        HStack {
                            Text(daily.dateFormatted)
                                .font(.custom(.regular(.bodySmall)))
                            Spacer()
                            Text(daily.temperature?.minFormatted ?? "")
                                .font(.custom(.medium(.bodySmall)))
                                .opacity(0.7)
                            
                            LinearGradient(colors: [.cyan, .yellow, .orange], startPoint: .leading, endPoint: .trailing)
                                .frame(width: 20, height: 4)
                                .mask(RoundedRectangle(cornerRadius: 8))
                            
                            Text(daily.temperature?.maxFormatted ?? "")
                                .font(.custom(.medium(.bodySmall)))
                        }
                        Divider().overlay(Color.quartenaryBrand)
                    }
                    .padding([.horizontal], .custom(.small))
                    .padding([.top], .custom(.smallest))
                    
                }
            }
            .padding([.vertical], .custom(.small))
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(LinearGradient(colors: [Color.quartenaryBrand.opacity(0.8), Color.quartenaryBrand.opacity(0.6)], startPoint: .top, endPoint: .bottom))
                    .opacity(0.2))
        }
    }
}

struct DailyListView_Previews: PreviewProvider {
    static var previews: some View {
        DailyListView(title: "Previsão para 10 dias", dailyData: Array(repeating: DailyWeatherAttributes.fixture(), count: 5))
    }
}
