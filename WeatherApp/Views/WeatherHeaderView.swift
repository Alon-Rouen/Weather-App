//
//  WeatherHeaderView.swift
//  WeatherApp
//
//  Created by codecamp on 27.10.25.
//

import SwiftUI

struct WeatherHeaderView: View {
    let weather: WeatherResponse
    let unit: TemperatureUnit
    @EnvironmentObject var favorites: FavoritesManager

    var body: some View {
        VStack(spacing: 8) {
            // Ville + bouton favoris avec cercle et ombre pour l'étoile
            HStack {
                Text("\(weather.location.name), \(weather.location.country)")
                    .font(.title2)
                    .multilineTextAlignment(.center)

                Button(action: { favorites.toggle(weather.location.name) }) {
                    ZStack {
                        Circle()
                            .fill(Color.black.opacity(0.2))
                            .frame(width: 30, height: 30)

                        Image(systemName: favorites.isFavorite(weather.location.name) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
                    }
                }
            }

            // Température
            let temperature = unit == .celsius
                ? (weather.current.temp_c ?? 0.0)
                : (weather.current.temp_f ?? 0.0)

            Text("\(String(format: "%.1f", temperature))°")
                .font(.largeTitle)
                .bold()

            Text(weather.current.condition.text ?? "Aucune donnée météo")
                .foregroundColor(.secondary)

            // Icône météo sécurisé avec cercle derrière
            if let iconPath = weather.current.condition.icon {
                let iconUrlString = "https:" + iconPath
                if let iconUrl = URL(string: iconUrlString) {
                    ZStack {
                        // Cercle semi-transparent derrière l'icône
                        Circle()
                            .fill(Color.black.opacity(0.2))
                            .frame(width: 90, height: 90)

                        // Icône météo
                        AsyncImage(url: iconUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                } else {
                    // Fallback si URL invalide
                    ZStack {
                        Circle()
                            .fill(Color.black.opacity(0.2))
                            .frame(width: 90, height: 90)
                        
                        Image(systemName: "sun.max.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                    }
                }
            } else {
                ZStack {
                    Circle()
                        .fill(Color.black.opacity(0.2))
                        .frame(width: 90, height: 90)
                    
                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
            }

            // Humidité et vent
            HStack(spacing: 16) {
                HStack {
                    Image(systemName: "drop.fill")
                    Text("\(weather.current.humidity ?? 0)%")
                }

                HStack {
                    Image(systemName: "wind")
                    let windSpeed = unit == .celsius
                        ? (weather.current.wind_kph ?? 0.0)
                        : (weather.current.wind_mph ?? 0.0)
                    Text("\(String(format: "%.1f", windSpeed)) \(unit == .celsius ? "kph" : "mph")")
                }
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding()
    }
}
