//
//  CardService.swift
//  ExploreMate
//
//  Created by Jonathan Lin on 2024-04-18.
//

import Foundation
import CoreLocation

class CardService: NSObject {
    
    private var locationManager: CLLocationManager
    private let urlString = "https://places.googleapis.com/v1/places:searchNearby"
    
    var latitude: Double?
    var longitude: Double?
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    
    func fetchCardModels() async throws -> [CardModel] {
        guard let url = URL(string: urlString) else {return []}
        guard ApiCreds.key != nil else { return [] }
                
        let headers = [
            "Content-Type": "application/json",
            "X-Goog-Api-Key": ApiCreds.key ?? "",
            "X-Goog-FieldMask": "places.displayName,places.shortFormattedAddress,places.id,places.rating,places.googleMapsUri,places.priceLevel,places.userRatingCount,places.photos,places.editorialSummary"
        ]
        
        let jsonInput = [
            "includedTypes": ["art_gallery", "museum", "amusement_center", "amusement_park", "aquarium", "bowling_alley", "casino", "hiking_area", "night_club", "park", "tourist_attraction", "zoo", "restaurant", "bar", "bakery", "cafe", "golf_course", "ski_resort"],
            "maxResultCount": 10,
            "locationRestriction": [
                "circle": [
                    "center": [
                        "latitude": self.latitude,
                        "longitude": self.longitude
                    ],
                    "radius": 500
                ]
            ],
        ] as [String : Any]
        
        let inputData = try! JSONSerialization.data(withJSONObject: jsonInput, options: [])
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = inputData as Data
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//            print("DEBUG: DATA ->\n\(jsonDictionary)")
            guard let locationsData = jsonDictionary["places"] as? [[String: Any]] else {
                // switch to throwing error later
                print("DEBUG: RETRIEVAL OF PLACES VALUE FAILED")
                return []
            }
            let locations = try JSONDecoder().decode([Location].self, from: JSONSerialization.data(withJSONObject: locationsData))
            
            return locations.map({ CardModel(location: $0)})
        } catch {
            print("DEBUG: Error \(error.localizedDescription)")
        }
        
        
        let mockLocations = MockData.locations
        return mockLocations.map({ CardModel(location: $0)})
    }
}

// Handle location retrieval
extension CardService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            print("Current Location: \(self.latitude!), \(self.longitude!)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            self.locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("Location services authorization denied or restricted.")
        case .notDetermined:
            print("Location services authorization status not determined.")
        @unknown default:
            fatalError("Unhandled CLAuthorizationStatus case.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}
