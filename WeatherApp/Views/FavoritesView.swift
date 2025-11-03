//
//  FavoritesView.swift
//  WeatherApp
//
//  Created by codecamp on 27.10.25.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favs: FavoritesManager
    var vm: WeatherViewModel
    @State private var selectedCity: String?

    var body: some View {
        List {
            ForEach(favs.cities, id: \.self) { city in
                Button(city) {
                    selectedCity = city
                    vm.fetch(city: city)
                }
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    favs.remove(favs.cities[index])
                }
            }
        }
        .navigationTitle("Favoris")
    }
}
