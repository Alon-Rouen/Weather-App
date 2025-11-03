//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by codecamp on 20.10.25.
//

import SwiftUI
import Foundation
import Combine
import CoreLocation

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let service = WeatherService()

    func fetch(city: String) {
        guard !city.isEmpty else { return }
        isLoading = true
        errorMessage = nil

        service.fetchWeather(for: city) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            if let result = result {
                self.weather = result
                CacheManager.shared.save(result)
            } else {
                self.errorMessage = "Impossible de récupérer la météo."
                if let cached = CacheManager.shared.load() {
                    self.weather = cached
                }
            }
        }
    }
}
