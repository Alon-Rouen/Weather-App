//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by codecamp on 20.10.25.
//

import SwiftUI
import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
    let region: String?
    let country: String
    let lat, lon: Double?
    let tz_id: String?
    let localtime: String?
}

struct Current: Codable {
    let temp_c: Double?
    let temp_f: Double?
    let is_day: Int?
    let condition: Condition
    let wind_kph: Double?
    let wind_mph: Double?
    let humidity: Int?
    let cloud: Int?
}

struct Condition: Codable {
    let text: String?
    let icon: String?
    let code: Int?
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let date: String
    let day: Day
}

struct Day: Codable {
    let maxtemp_c: Double?
    let mintemp_c: Double?
    let maxtemp_f: Double?
    let mintemp_f: Double?
    let condition: Condition
}
