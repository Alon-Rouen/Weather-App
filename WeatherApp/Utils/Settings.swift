//
//  Settings.swift
//  WeatherApp
//
//  Created by codecamp on 20.10.25.
//

import SwiftUI
import Foundation

enum TemperatureUnit: String {
    case celsius, fahrenheit
}

final class Settings: ObservableObject {
    static let shared = Settings()
    @Published var tempUnit: TemperatureUnit {
        didSet{
            UserDefaults.standard.set(tempUnit.rawValue, forKey: "tempUnitKey")
        }
    }
    
    private init() {
        let raw = UserDefaults.standard.string(forKey: "tempUnitKey") ?? TemperatureUnit.celsius.rawValue
        tempUnit = TemperatureUnit(rawValue: raw) ?? .celsius
    }
}
