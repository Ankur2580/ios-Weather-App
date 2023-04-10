////
////  Weather.swift
////  Weather App
////
////  Created by Ankur Kothawade on 2/7/23.
////
//
//
////"https://api.openweathermap.org/data/2.5/forecast?q=\(Cities.location)&appid=\(API.key)&units=\(Units.celcius)"
//import Foundation
//
//struct FiveDaysWeatherData: Decodable {
//    let list: [List]
//}
//
//struct List: Decodable {
//    let date: String
//    let main: MainClass
//    let weather: [Weather2]
//
//    enum CodingKeys: String, CodingKey{
//        case date = "dt_txt"
//        case main
//        case weather
//    }
//}
//
//struct MainClass: Codable {
//    let temp: Double
//}
//
//struct Weather2: Codable {
//    let main: String
//}
//
