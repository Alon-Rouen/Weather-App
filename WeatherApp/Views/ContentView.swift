//
//  ContentView.swift
//  WeatherApp
//
//  Created by codecamp on 20.10.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = WeatherViewModel()
    @StateObject private var favs = FavoritesManager()
    @StateObject private var settings = Settings.shared
    @State private var city = "Paris"

    var body: some View {
        NavigationStack {
            ZStack {
                // 🔹 Fond dynamique selon la météo
                if let w = vm.weather {
                    WeatherBackgroundView(weather: w)
                } else {
                    Color.blue.opacity(0.2) // Fond par défaut
                        .edgesIgnoringSafeArea(.all)
                }

                // 🔹 Contenu principal
                VStack {
                    // Picker unités
                    Picker("Unités", selection: $settings.tempUnit) {
                        Text("°C / kph").tag(TemperatureUnit.celsius)
                        Text("°F / mph").tag(TemperatureUnit.fahrenheit)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)

                    // Liste horizontale des favoris
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(favs.cities, id: \.self) { favCity in
                                Button(action: {
                                    city = favCity
                                    vm.fetch(city: favCity)
                                }) {
                                    Text(favCity)
                                        .padding(8)
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Champ ville
                    HStack {
                        TextField("Ville", text: $city)
                            .textFieldStyle(.roundedBorder)
                            .padding(.leading)
                        Button("OK") { vm.fetch(city: city) }
                            .buttonStyle(.borderedProminent)
                            .padding(.trailing)
                    }

                    // Météo
                    if let w = vm.weather {
                        WeatherHeaderView(weather: w, unit: settings.tempUnit)
                            .environmentObject(favs)

                        ForecastListView(forecast: w.forecast, unit: settings.tempUnit)
                            .padding(.top)

                        Spacer()

                        Button("Ajouter aux favoris") { favs.add(w.location.name) }
                            .buttonStyle(.bordered)
                            .padding()
                    } else {
                        Text(vm.errorMessage ?? "Entrez une ville pour voir la météo")
                            .foregroundColor(.secondary)
                            .padding()
                    }

                    NavigationLink("Voir mes favoris") {
                        FavoritesView(favs: favs, vm: vm)
                    }
                    .padding()
                }
            }
            .navigationTitle("WeatherApp")
        }
        .onAppear { vm.fetch(city: city) }
    }
}

