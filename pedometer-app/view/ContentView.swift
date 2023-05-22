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
    @State private var distance = 0.0


    var body: some View {
        TabView {
            HomepageView()
                .environmentObject(appData)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Homepage")
                }
            StatisticsView(distance: appData.distance)
                .environmentObject(appData)
                .tabItem {
                    Image(systemName: "figure.walk")
                    Text("Statistics")
                }
        }
    }
}
