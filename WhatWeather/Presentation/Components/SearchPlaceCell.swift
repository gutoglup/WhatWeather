//
//  SearchPlaceCell.swift
//  WhatWeather
//
//  Created by Augusto Reis on 10/08/22.
//

import SwiftUI

struct SearchPlaceCell: View {
    
    private let addressLocation: AddressLocation
    
    init(addressLocation: AddressLocation) {
        self.addressLocation = addressLocation
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .lastTextBaseline) {
                    Text(addressLocation.name)
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(Color.primaryBrand)
                    Spacer()
                    Text(addressLocation.state ?? "")
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .foregroundColor(Color.primaryBrand)
                    Text(addressLocation.country)
                        .font(.system(size: 12, weight: .medium, design: .default))
                        .foregroundColor(Color.primaryBrand)
                }
                
            }
            .padding()
            Divider()
                .padding([.horizontal])
                .padding([.vertical], 0)
        }
    }
}

struct SearchPlaceCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlaceCell(
            addressLocation: .fixture())
    }
}
