//
//  WeatherBackgroundView.swift
//  WeatherApp
//
//  Created by codecamp on 03.11.25.
//

import SwiftUI

struct WeatherBackgroundView: View {
    let weather: WeatherResponse

    // 🔹 Fonction pour choisir les couleurs selon la météo
    func gradientColors() -> [Color] {
        guard let text = weather.current.condition.text?.lowercased() else {
            return [.blue, .cyan]
        }

        if text.contains("rain") {
            return [.blue.opacity(0.7), .gray.opacity(0.6)]
        } else if text.contains("cloud") {
            return [.gray, .white]
        } else if text.contains("sun") || text.contains("clear") {
            return [.yellow, .orange]
        } else {
            return [.blue, .cyan]
        }
    }

    var body: some View {
        LinearGradient(colors: gradientColors(), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

