//
//  ErrorView.swift
//  WhatWeather
//
//  Created by Augusto Reis on 03/08/22.
//

import SwiftUI

struct ErrorView: View {
    var error: Error
    var retryAction: (() -> Void)
    
    var body: some View {
        VStack(alignment: .center) {
            Text(error.localizedDescription)
                .padding([.bottom], 4)
            Button(action: retryAction) {
                Text("Try again")
            }
        }.padding([.horizontal], 12)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: DataError.cannotUnwrapWeather) {
            
        }
    }
}
