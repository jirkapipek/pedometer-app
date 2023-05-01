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
    @StateObject var weatherManager = WeatherManager()
    
    @State private var isWalking = false
    @State private var locations: [LocationAnnotation] = []
    
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
                        Text("\(Int(weather.temperature_2m)) °C")
                            .foregroundColor(.white)
                            .font(.body)
                            .padding(5)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .padding(.trailing, 5)
                            .padding(.vertical, 5)
                        
                        
                        Text("\(Int(weather.windspeed_10m)) m/s")
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
                        locations.removeAll()
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
            }
        }
        .onReceive(locationManager.$location) { location in
            if isWalking {
                locations.append(LocationAnnotation(location: location!))
            }
            if let location = location {
                weatherManager.fetchWeatherData(for: location)
            }
        }
    }
}
struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
