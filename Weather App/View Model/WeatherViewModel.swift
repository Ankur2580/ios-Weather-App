//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Ankur Kothawade on 2/9/23.
//

import Foundation

final class WeatherViewModel {
    
//    var weather = [list]()
    
    var weather: Welcome?
    
    var eventHandler: ((_ event : Event) -> Void)?  // Data Binding Closure
    
    func fetchWeather(city: String) {
        self.eventHandler?(.loading)
        APIManager.shared.fetchWeather(city: city, completion: { [self] response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let weather) :
//                print("weather",weather)
//                self.weather.append(weather)
                self.weather = weather
                print("Count -------------------------------" ,self.weather?.list.count ?? 0)
//                print(weather)
                self.eventHandler?(.dataLoaded)
            case .failure(let error) :
                print("error--",error)
                self.eventHandler?(.error(error))
            }
        
        })
    }
}

extension WeatherViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error)
    }
}
