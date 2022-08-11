//
//  String+Extension.swift
//  WhatWeather
//
//  Created by Augusto Reis on 11/08/22.
//

import Foundation

extension String {
    
    func urlPathFromDocuments(fileExtension: String) -> URL {
        var fileUrl = try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.asURL()
        fileUrl.appendPathComponent(self)
        fileUrl.appendPathExtension(fileExtension)
        return fileUrl
    }
}
