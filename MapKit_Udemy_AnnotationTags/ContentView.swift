//
//  ContentView.swift
//  MapKit_Udemy_AnnotationTags
//
//  Created by tom montgomery on 12/27/23.
//

import SwiftUI
import MapKit

enum PlaceType {
    
    case coffee
    case burger
}

// If you place this struct in a different file, import CoreLocation.  Mapkit includes CL for here though.
struct Place: Identifiable, Hashable {
    // need to make it Hashable so it can be a .tag
let id = UUID()
    let name: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let placeType: PlaceType
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

}

struct ContentView: View {
    
    let places = [Place(name: "Starbucks", latitude: 37.337295, longitude: -122.014978, placeType: .coffee), Place(name: "Smashburger", latitude: 37.333112, longitude: -122.014867, placeType: .burger)]
    
    @State private var selectedPlace: Place?
    
    var body: some View {
        // use 'selection' to leverage .tag
        Map(selection: $selectedPlace) {
            ForEach(places) { place in
                switch place.placeType {
                case .burger:
                    Marker(place.name, coordinate: place.coordinate)
                        .tag(place)
                case .coffee:
                    Annotation(place.name, coordinate: place.coordinate) {
                     Image(systemName: "cup.and.saucer.fill")
                    }
                    .tag(place)
                }
            }
        }
        .onChange(of: selectedPlace) {
            // no binding here b/c we are not writing to it
            if let place = selectedPlace {
                print(place)
            }
        }
    }
}

#Preview {
    ContentView()
}
