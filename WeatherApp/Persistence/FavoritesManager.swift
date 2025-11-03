//
//  FavoritesManager.swift
//  WeatherApp
//
//  Created by codecamp on 20.10.25.
//

import Foundation
import SwiftUI
import Combine

final class FavoritesManager: ObservableObject {
    @Published var cities: [String] {
        didSet {
            UserDefaults.standard.set(cities, forKey: "favorites")
        }
    }

    init() {
        self.cities = UserDefaults.standard.stringArray(forKey: "favorites") ?? []
    }

    func add(_ city: String) {
        if !cities.contains(city) {
            cities.append(city)
        }
    }

    func remove(_ city: String) {
        if let index = cities.firstIndex(of: city) {
            cities.remove(at: index)
        }
    }

    func toggle(_ city: String) {
        if cities.contains(city) {
            remove(city)
        } else {
            add(city)
        }
    }

    func isFavorite(_ city: String) -> Bool {
        cities.contains(city)
    }
}

