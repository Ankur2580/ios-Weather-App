//
//  APIManager.swift
//  Weather App
//
//  Created by Ankur Kothawade on 2/7/23.
//

import Foundation

enum DataError : Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

typealias Handler = (Result<Welcome, DataError>) -> Void

class APIManager {
    static let shared = APIManager()
    private init () {}
    
    func fetchWeather(city: String, completion : @escaping Handler){
        guard let url = URL(string: Constant.instance.getWeatherURL(city: city)) else {
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data,response,error) in
            guard let edata = data , error == nil else {
                completion(.failure(.invalidData))
                return
            }

            guard let response = response as? HTTPURLResponse,
            200 ... 299 ~= response.statusCode
            else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do{
                let weatherData = try JSONDecoder().decode(Welcome.self, from: edata)
                completion(.success(weatherData))
            }
            
            catch{
                completion(.failure(.network(error)))
            }


        }).resume()
    }
}
