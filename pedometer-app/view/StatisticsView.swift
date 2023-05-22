//
//  StatisticsView.swift
//  pedometer-app
//
//  Created by Jiří Pipek on 07.05.2023.
//
import SwiftUI

struct StatisticsView: View {
    var distance: Double
    
    var caloriesBurned: Double {
        // Vzorec pro odhad spálených kalorií při chůzi
        // 0.5 kcal / kg / km * hmotnost v kg * vzdálenost v km
        let weightInKg = 70.0 // Váha v kg
        let caloriesPerKilometerPerKilogram = 0.5
        return caloriesPerKilometerPerKilogram * weightInKg * (distance / 1000.0)
    }
    
    var body: some View {
        VStack {
            Text("Ujitá vzdálenost: \(String(format: "%.2f", distance / 1000.0)) km")
            Text("Spálené kalorie: \(String(format: "%.2f", caloriesBurned)) kcal")
        }
    }
}
