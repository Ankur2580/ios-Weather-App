//
//  Constant.swift
//  Weather App
//
//  Created by Ankur Kothawade on 2/7/23.
//

import Foundation


final class Constant {
    static let instance = Constant()
    
    let apikey = "425cf6457e6859fd6e8cb8c1227027b4"
    func getWeatherURL(city: String) -> String {
        return "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apikey)&units=metric"
    }
}




