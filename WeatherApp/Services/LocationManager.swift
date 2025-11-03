//
//  LocationManager.swift
//  WeatherApp
//
//  Created by codecamp on 27.10.25.
//

import SwiftUI
import CoreLocation
import Combine
import Foundation

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        DispatchQueue.main.async {
            self.authorizationStatus = status
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            self.location = locations.last
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erreur de localisation :", error.localizedDescription)
    }
}

