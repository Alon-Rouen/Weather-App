//
//  ForecastListView.swift
//  WeatherApp
//
//  Created by codecamp on 27.10.25.
//

import SwiftUI

struct ForecastListView: View {
    let forecast: Forecast
    let unit: TemperatureUnit

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(forecast.forecastday, id: \.date) { day in
                    VStack(spacing: 8) {
                        // Date
                        Text(day.date)
                            .font(.caption)
                            .bold()

                        // Icône météo sécurisée
                        if let iconPath = day.day.condition.icon {
                            let iconUrlString = "https:" + iconPath
                            if let iconUrl = URL(string: iconUrlString) {
                                AsyncImage(url: iconUrl) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 40, height: 40)
                            } else {
                                Image(systemName: "cloud.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                            }
                        } else {
                            Image(systemName: "cloud.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        }

                        // Température max / min
                        HStack(spacing: 4) {
                            let maxTemp = unit == .celsius
                                ? day.day.maxtemp_c ?? 0.0
                                : day.day.maxtemp_f ?? 0.0
                            let minTemp = unit == .celsius
                                ? day.day.mintemp_c ?? 0.0
                                : day.day.mintemp_f ?? 0.0

                            Text("\(Int(maxTemp))° / \(Int(minTemp))°")
                                .font(.caption2)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
    }
}
