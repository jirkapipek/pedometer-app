//
//  ContentView.swift
//  pedometer-app
//
//  Created by Jiří Pipek on 01.05.2023.
//

import SwiftUI
import MapKit

struct LocationAnnotation: Identifiable {
    let id = UUID()
    let location: CLLocation
}

struct HomepageView: View {
    @StateObject var locationManager = LocationManager()
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var profileData: UserData
    @EnvironmentObject var weatherManager: WeatherManager

    @State private var showDistance = false
    @State private var isWalking = false
    @State private var locations: [LocationAnnotation] = []
    @State private var distanceInMeters: Double = 0

    var body: some View {
        ZStack {
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.location.coordinate) {
                    Image(systemName: "map.fill")
                        .foregroundColor(.blue)
                        .opacity(0.5)
                        .frame(width: 5)
                    
                }
            }
            VStack {
                HStack {
                    Spacer()
                    
                    if let weather = weatherManager.weather?.current_weather {
                        Text("\(String(format: "%.1f", weather.temperature )) °C")
                            .foregroundColor(.white)
                            .font(.body)
                            .padding(5)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .padding(.trailing, 5)
                            .padding(.vertical, 5)
                        
                        
                        Text("\(String(format: "%.1f", weather.windspeed)) m/s")
                            .foregroundColor(.white)
                            .font(.body)
                            .padding(5)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .padding(.trailing, 5)
                            .padding(.vertical, 5)
                        
                    } else {
                        Text("NaN °C")
                            .foregroundColor(.white)
                            .font(.body)
                            .padding(5)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .padding(.trailing, 5)
                            .padding(.vertical, 5)
                        
                        
                        Text("NaN m/s")
                            .foregroundColor(.white)
                            .font(.body)
                            .padding(5)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .padding(.trailing, 5)
                            .padding(.vertical, 5)
                    }
                }
                
                Spacer()
                Button(action: {
                    isWalking.toggle()
                    if isWalking {
                        distanceInMeters = 0
                        let coordinates = locations.map { $0.location.coordinate }
                        distanceInMeters = calculateTotalDistance(coordinates: coordinates)
                        appData.distance += distanceInMeters
                        locations.removeAll()
                    } else {
                        distanceInMeters = 0
                        let coordinates = locations.map { $0.location.coordinate }
                        distanceInMeters = calculateTotalDistance(coordinates: coordinates)
                        showDistance = true
                        appData.distance = distanceInMeters

                    }
                }, label: {
                    Text(isWalking ? "Ukončit chůzi" : "Zahájit chůzi")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(isWalking ? Color.red : Color.green)
                        .cornerRadius(10)
                })
                .padding()
                // Následující kód zobrazí WalkSummaryView po stisknutí tlačítka "Ukončit chůzi"
                .sheet(isPresented: $showDistance) {
                    StatisticsView(userData: profileData, distance: distanceInMeters)
                }
            }
        }
        .onReceive(locationManager.$location) { location in
            if isWalking {
                DispatchQueue.main.async {
                locations.append(LocationAnnotation(location: location!))
                }
            }
            if let location = location {
                DispatchQueue.main.async {
                    weatherManager.startFetchingWeatherData(for: location)
                }
            }
        }
    }
    
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
func calculateTotalDistance(coordinates: [CLLocationCoordinate2D]) -> Double {
    var distanceInMeters = 0.0
    if coordinates.count >= 2 {
    for i in 0..<coordinates.count-1 {
        let origin = coordinates[i]
        let destination = coordinates[i+1]
        let originLocation = CLLocation(latitude: origin.latitude, longitude: origin.longitude)
        let destinationLocation = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
        distanceInMeters += destinationLocation.distance(from: originLocation)
    }
    }
    return distanceInMeters
}

