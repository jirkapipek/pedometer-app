//
//  ContentView.swift
//  pedometer-app
//
//  Created by Jiří Pipek on 07.05.2023.
//

import Foundation
import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var appData = AppData()
    @StateObject var profileData = UserData()
    @StateObject var weatherManager = WeatherManager()

    @State private var distance = 0.0


    var body: some View {
        TabView {
            HomepageView()
                .environmentObject(appData)
                .environmentObject(profileData)
                .environmentObject(weatherManager)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Homepage")
                }
            ProfileView()
                .environmentObject(profileData)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            RecordsView(userData: profileData)
                .environmentObject(profileData)
                .tabItem {
                    Image(systemName: "clock")
                    Text("Recent")
                }
        }
    }
}
