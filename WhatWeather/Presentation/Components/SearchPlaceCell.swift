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
                        .font(.custom(.bold(.bodyMedium)))
                        .foregroundColor(Color.primaryBrand)
                    Spacer()
                    Text(addressLocation.state ?? "")
                        .font(.custom(.regular(.caption)))
                        .foregroundColor(Color.primaryBrand)
                    Text(addressLocation.country)
                        .font(.custom(.regular(.caption)))
                        .foregroundColor(Color.primaryBrand)
                }
                
            }
            .padding()
            Divider()
                .padding([.horizontal])
                .padding([.vertical], .custom(.none))
        }
    }
}

struct SearchPlaceCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlaceCell(
            addressLocation: .fixture())
    }
}
