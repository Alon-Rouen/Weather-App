//
//  CacheManager.swift
//  WeatherApp
//
//  Created by codecamp on 20.10.25.
//

import SwiftUI
import Foundation

final class CacheManager {
    static let shared = CacheManager()
    private init() {}

    private let key = "cachedWeather"

    func save(_ weather: WeatherResponse) {
        if let data = try? JSONEncoder().encode(weather) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load() -> WeatherResponse? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
