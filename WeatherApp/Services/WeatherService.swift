//
//  WeatherService.swift
//  WeatherApp
//
//  Created by codecamp on 20.10.25.
//

import SwiftUI
import Foundation

final class WeatherService {
    private let apiKey = Constants.weatherAPIKey
    private let baseURL = Constants.weatherBaseURL

    func fetchWeather(for city: String, completion: @escaping (WeatherResponse?) -> Void) {
        let encoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "\(baseURL)/forecast.json?key=\(apiKey)&q=\(encoded)&days=3&aqi=no&alerts=no"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                print("Erreur de décodage:", error)
                completion(nil)
            }
        }.resume()
    }
}

