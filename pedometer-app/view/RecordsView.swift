
//
//  RecentRecordsView.swift
//  pedometer-app
//
//  Created by Jiří Pipek on 28.05.2023.
//

import Foundation
import SwiftUI

struct RecordsView: View {
    @ObservedObject var userData: UserData
    
    var body: some View {
        VStack {
            Text("Poslední záznamy:")
                .font(.headline)
                .padding()
            
            List(userData.recentRecords, id: \.self) { record in
                HStack {
                    Text("Vzdálenost: \(String(format: "%.2f", record.distance / 1000.0)) km")
                    Spacer()
                    Text("Kalorie: \(String(format: "%.2f", record.caloriesBurned)) kcal")
                }
                .padding()
            }
            
            if userData.recentRecords.isEmpty {
                Text("Žádné záznamy k dispozici.")
                    .padding(.top)
            }
        }
        .navigationBarTitle("Poslední záznamy")
    
    }
}
