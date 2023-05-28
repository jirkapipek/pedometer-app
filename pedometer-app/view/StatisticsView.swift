//
//  StatisticsView.swift
//  pedometer-app
//
//  Created by Jiří Pipek on 07.05.2023.
//
import SwiftUI

struct StatisticsView: View {
    @ObservedObject var userData: UserData
    var distance: Double
    
    var caloriesBurned: Double {
        let weightInKg = userData.weight
        let caloriesPerKilometerPerKilogram = 0.5
        print(weightInKg)
        let factor = userData.gender == .male ? 1.0 : 0.9 // Úprava pro pohlaví
        return caloriesPerKilometerPerKilogram * weightInKg * (distance / 1000.0) * factor
    }
    
    var body: some View {
        VStack {
            Text("Ujitá vzdálenost: \(String(format: "%.2f", distance / 1000.0)) km")
            Text("Spálené kalorie: \(String(format: "%.2f", caloriesBurned)) kcal")
        }
        .onAppear {
            userData.recentRecords.append(Record(distance: distance, caloriesBurned: caloriesBurned))
        }
    }
}
